import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class VerifyUserUseCase {
  final AuthRepository repository;

  VerifyUserUseCase(this.repository);

  Future<User> call(int nit) async {
    return await repository.verifyUser(nit);
  }
}
