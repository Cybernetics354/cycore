part of cypage;

abstract class CypageController<T> {
  T? lastData;
  CypageSnapshot<T>? lastState;

  /// Stream Controller for [state]
  final BehaviorSubject<CypageSnapshot<T>> stateController =
      new BehaviorSubject<CypageSnapshot<T>>();

  /// Stream pipe for [stateController]
  Stream<CypageSnapshot<T>> get stateStream => stateController.stream;

  /// Stream sink for [stateController]
  StreamSink<CypageSnapshot<T>> get stateIn => stateController.sink;

  @mustCallSuper
  void dispose() {
    stateController.close();
  }

  // Initial function
  T initial();

  /// Function for change state to Active
  void active(T data) {
    lastData = data;

    // Assign if the value is null
    lastState ??= CypageSnapshot<T>(
      data: data,
      state: _CypageState.active,
    );

    lastState!.data = lastData!;
    stateIn.add(lastState!);
  }

  /// Function for change state to Loading
  void loading({dynamic data}) {
    lastState ??= CypageSnapshot<T>(
      state: _CypageState.loading,
    );

    lastState!.loading = data;
    stateIn.add(lastState!);
  }

  /// Function for change state to Error
  void error(dynamic error) {
    lastState ??= CypageSnapshot(
      state: _CypageState.error,
    );

    lastState!.error = error;
    stateIn.add(lastState!);
  }
}
