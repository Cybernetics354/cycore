part of cypage;

/// Abstract error model, use this for creating Custom
/// CypageError, example
///
/// ```dart
/// class NetworkError extends CypageError {
///   NetworkError(error) : super(error);
/// }
/// ```
abstract class CypageError {
  dynamic error;

  CypageError(this.error);
}

class NetworkError extends CypageError {
  NetworkError(error) : super(error);
}
