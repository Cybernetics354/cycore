part of cypage;

abstract class CypageController<T> {
  T? lastData;
  CypageSnapshot<T>? lastState;

  /// Stream Controller for [state]
  final BehaviorSubject<CypageSnapshot<T>> stateController =
      new BehaviorSubject<CypageSnapshot<T>>();

  /// Stream pipe for [stateController]
  Stream<CypageSnapshot<T>> get stateStream => stateController.stream;

  Stream<CypageSnapshot<T>>? get mainStream;

  /// Stream sink for [stateController]
  StreamSink<CypageSnapshot<T>> get _stateIn => stateController.sink;

  /// Stream Controller for [event]
  final BehaviorSubject<CypageEvent> _eventController = new BehaviorSubject<CypageEvent>();

  /// Handle event, it's useful for mapping
  /// event from abstract class level
  @mustCallSuper
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
    lastState!.state = _CypageState.active;
    _insert(lastState!);
  }

  /// Function for change state to Loading
  void loading({dynamic data}) {
    lastState ??= CypageSnapshot<T>(
      state: _CypageState.loading,
    );

    lastState!.loading = data;
    lastState!.state = _CypageState.loading;
    _insert(lastState!);
  }

  /// Function for change state to Error
  void error(dynamic error) {
    lastState ??= CypageSnapshot<T>(
      state: _CypageState.error,
    );

    lastState!.error = error;
    lastState!.state = _CypageState.error;
    _insert(lastState!);
  }

  void addEvent(CypageEvent event) {
    if (_eventController.isClosed) return;
    _eventController.add(event);
  }

  void _insert(CypageSnapshot<T> event) {
    if (stateController.isClosed) return;
    _stateIn.add(event);
  }

  @mustCallSuper
  void dispose() {
    stateController.close();
    _eventController.close();
  }

  CypageController() {
    _eventController.listen(handleEvent);
    loading();
  }
}
