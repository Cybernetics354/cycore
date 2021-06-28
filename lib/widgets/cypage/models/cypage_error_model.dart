part of cypage;

abstract class CypageError {
  dynamic error;

  CypageError(this.error);
}

class NetworkError extends CypageError {
  NetworkError(error) : super(error);
}
