part of cypage;

abstract class CypageController<T> {
  T? lastData;
  CypageSnapshot<T> get lastState =>
      stateController.valueOrNull ??
      CypageSnapshot<T>(
        state: CypageState.loading,
      );

  /// Stream Controller for [snapshot]
  final BehaviorSubject<CypageSnapshot<T>> stateController =
      new BehaviorSubject<CypageSnapshot<T>>();

  /// Stream pipe for [stateController]
  Stream<CypageSnapshot<T>> get stateStream => stateController.stream;

  Stream<CypageSnapshot<T>>? get mainStream => stateStream;

  /// Stream sink for [stateController]
  StreamSink<CypageSnapshot<T>> get _stateIn => stateController.sink;

  /// Stream Controller for [event]
  final BehaviorSubject<CypageEvent> _eventController = new BehaviorSubject<CypageEvent>();

  /// Handle event, it's useful for mapping
  /// event from abstract class level
  void handleEvent(CypageEvent event) {}

  /// Function for change state to Active
  void active(T data) {
    lastData = data;

    _insert(lastState.copy(
      data: lastData,
      state: CypageState.active,
    ));
  }

  /// Function for change state to Loading
  void loading({CypageLoading? data}) {
    _insert(lastState.copy(
      loading: data,
      state: CypageState.loading,
    ));
  }

  /// Function for change state to Error
  void error(CypageError error) {
    _insert(lastState.copy(
      error: error,
      state: CypageState.error,
    ));
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
