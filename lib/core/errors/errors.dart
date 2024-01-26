abstract class AppError implements Exception {
  AppError(this.message, {this.trace});
  String message;
  StackTrace? trace;
}

class ExternalError extends AppError {
  ExternalError(super.message, {super.trace});
}

class UnauthorizedError extends ExternalError {
  UnauthorizedError(super.message, {super.trace});
}

class ClientError extends AppError {
  ClientError(super.message, {super.trace});
}

class NoConnectionError extends AppError {
  NoConnectionError(super.message, {super.trace});
}
