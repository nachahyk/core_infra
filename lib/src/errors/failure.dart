/// Base type for recoverable failures surfaced from the data layer to the UI.
sealed class Failure {
  const Failure(this.message);

  final String message;
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Something went wrong on the server.']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'No local data available.']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection.']);
}
