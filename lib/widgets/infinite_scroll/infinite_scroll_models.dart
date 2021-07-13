part of infinite_scroll;

/// Random error state on infinite scroll error
class InfiniteScrollError extends CypageError {
  InfiniteScrollError(error) : super(error);
}

/// Infinite scroll snapshot, contains data, error, and state
class InfiniteScrollSnapshot<T> {
  /// Data with generic value, this field is
  /// used to store the data from infinite scroll controller
  T data;

  /// Snapshot state, it can be error, loading, or active
  /// depend on the process
  InfiniteScrollState state;

  /// Error that occured when fetching and catched, useful
  /// to custom handle some specific error.
  CypageError? error;

  InfiniteScrollSnapshot({
    required this.data,
    required this.state,
    this.error,
  });

  bool get isFetching => state == InfiniteScrollState.loading;
  bool get isErrorOccured => state == InfiniteScrollState.error;
}

/// Infinite scroll state
enum InfiniteScrollState {
  error,
  loading,
  active,
}
