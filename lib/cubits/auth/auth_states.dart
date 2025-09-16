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
  final String uid;
  final String userName;
  final String accessToken;
  final String refreshToken;

  const AuthSuccess({
    required this.uid,
    required this.userName,
    required this.accessToken,
    required this.refreshToken,
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
