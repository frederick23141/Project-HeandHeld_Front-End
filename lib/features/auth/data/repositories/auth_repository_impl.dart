import 'package:handheld_beta/features/auth/data/datasources/aut_remote_data_source.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<User> verifyUser(int nit) async {
    return await remoteDataSource.verifyUser(nit);
  }
}
