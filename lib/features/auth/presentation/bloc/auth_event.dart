// auth_event.dart
abstract class AuthEvent {}

class VerifyUserEvent extends AuthEvent {
  final int nit;
  VerifyUserEvent(this.nit);
}
