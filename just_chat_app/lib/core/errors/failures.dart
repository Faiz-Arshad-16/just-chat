abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  final String message;
  ServerFailure(this.message) : super('');
}

class CacheFailure extends Failure {
  CacheFailure() : super('Cache error occurred');
}