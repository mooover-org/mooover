class AppException implements Exception {
  final String message;

  const AppException(this.message);

  @override
  String toString() {
    return 'Error: $message';
  }
}

class LoginException extends AppException {
  LoginException({String message = "login error"}) : super(message);
}

class LogoutException extends AppException {
  LogoutException({String message = "logout error"}) : super(message);
}
