part of cypage;

abstract class CypageEvent {}

class CypageSnapshot<T> {
  T? data;
  dynamic error;
  dynamic loading;
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
