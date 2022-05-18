class AppException implements Exception {
  final String message;

  const AppException({this.message = "Something bad happened."});

  @override
  String toString() {
    return message;
  }
}

class LoginException extends AppException {
  LoginException({String message = "Something happened while trying to login."}) : super(message: message);
}

class LogoutException extends AppException {
  LogoutException({String message = "Something happened while trying to logout."}) : super(message: message);
}
