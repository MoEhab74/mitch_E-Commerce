import 'package:minimal_e_commerce/models/user_model.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess extends AuthState {
  final UserModel user;

  const AuthSuccess({
    required this.user
  });
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}

class AuthLoggedOut extends AuthState {
  const AuthLoggedOut();
}

class AuthRefreshing extends AuthState {
  const AuthRefreshing();
}
