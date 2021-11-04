part of cypage;

/// Snapshot of the current state
class CypageSnapshot<T> {
  T? data;
  CypageError? error;
  CypageLoading? loading;
  CypageState state;

  CypageSnapshot({
    required this.state,
    this.data,
    this.error,
    this.loading,
  });

  bool get isLoading => state == CypageState.loading;
  bool get isError => state == CypageState.error;
  bool get isActive => state == CypageState.active;

  bool get hasData => data != null;

  CypageSnapshot<T> copy({
    T? data,
    CypageError? error,
    CypageLoading? loading,
    CypageState? state,
  }) =>
      CypageSnapshot(
        state: state ?? this.state,
        data: data ?? this.data,
        error: error ?? this.error,
        loading: loading ?? this.loading,
      );
}

enum CypageState {
  loading,
  error,
  active,
}
