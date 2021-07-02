part of cypage;

/// Snapshot of the current state
class CypageSnapshot<T> {
  T? data;
  CypageError? error;
  CypageLoading? loading;
  _CypageState state;

  CypageSnapshot({
    required this.state,
    this.data,
    this.error,
    this.loading,
  });

  bool get isLoading => state == _CypageState.loading;
  bool get isError => state == _CypageState.error;
  bool get isActive => state == _CypageState.active;
}

enum _CypageState {
  loading,
  error,
  active,
}
