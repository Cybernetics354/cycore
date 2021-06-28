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

  /// Stream Controller for [event]
  final BehaviorSubject<CypageEvent> _eventController = new BehaviorSubject<CypageEvent>();

  /// Handle event, it's useful for mapping
  /// event from abstract class level
  void handleEvent(CypageEvent event);

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

  void addEvent(CypageEvent event) {
    if (_eventController.isClosed) return;
    _eventController.add(event);
  }

  @mustCallSuper
  void dispose() {
    stateController.close();
    _eventController.close();
  }

  CypageController() {
    _eventController.listen(handleEvent);
  }
}
