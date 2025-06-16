import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/verify_user_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final VerifyUserUseCase verifyUserUseCase;

  AuthBloc({required this.verifyUserUseCase}) : super(AuthInitial()) {
    on<VerifyUserEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await verifyUserUseCase(event.nit as int);
        emit(AuthSuccess(user));
      } catch (e) {
        emit(AuthFailure('Fallo al verificar usuario: ${e.toString()}'));
      }
    });
  }
}
