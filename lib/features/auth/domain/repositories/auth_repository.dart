import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> verifyUser(int nit);
}
