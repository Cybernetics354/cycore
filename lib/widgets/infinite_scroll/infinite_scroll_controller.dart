part of infinite_scroll;

abstract class InfiniteScrollController<T>
    extends CypageController<InfiniteScrollSnapshot<List<T>>> {
  /// Infinite scroll state
  InfiniteScrollSnapshot<List<T>> snapshot = InfiniteScrollSnapshot(
    data: [],
    state: InfiniteScrollState.loading,
  );

  /// Listening offset stream to invoke callback whether the conditions meet
  /// the requiremets
  StreamSubscription<double>? _offsetStreamListener;

  /// Fetching function / callback when the scroll listener meet the
  /// requirement conditions
  Future<List<T>> Function(int offset)? _callback;

  /// Scroll Controller that will be listened and invoke some callback
  /// when the requirements conditions meets
  ScrollController? scrollController;

  /// Fetching process, using stream subscription so it can be cancelled anytime
  /// or disposable when it's not needed by controller anymore
  StreamSubscription<List<T>>? process;

  /// Scroll listener callback, used for easy to remove listener on scrollcontroller
  /// listen
  VoidCallback? scrollListener;

  /// Completer to wait the initial fetch
  Completer initialFetch = new Completer();

  /// Scroll thereshold to invoke the function
  double? _scrollThereshold;

  /// Locker when the infinite scroll is fetching, so for prevent the
  /// other fetch, we need to lock with bool.
  bool _isFetching = false;

  /// Showing whether the infinite scroll is on finished fetching all
  /// the data, so when users scroll to edge, this controller not fetching
  /// anymore until this got refreshed.
  bool _isFinish = false;

  /// Showing whether this controller using custom scroll from constructor
  /// or not, the dispose method is different.
  bool _customScroll = false;

  /// Stream Controller for [offset]
  final BehaviorSubject<double> _offsetController = new BehaviorSubject<double>();

  /// Stream pipe for [_offsetController]
  Stream<double> get offsetStream => _offsetController.stream;

  /// Stream sink for [_offsetController]
  StreamSink<double> get offsetIn => _offsetController.sink;

  /// Inputing event to CypageController
  _inputEvent(InfiniteScrollSnapshot<List<T>> newState) {
    if (stateController.isClosed) return;
    active(newState);
  }

  /// Callback called when the fetch is finished
  _finish(
    List<T>? list,
  ) {
    if (initialFetch.isCompleted) initialFetch.complete();

    if (list != null) {
      if (list.length == 0) {
        _isFinish = true;
      }

      snapshot.data.addAll(list);
    }

    snapshot.state = InfiniteScrollState.active;

    _inputEvent(snapshot);
  }

  /// Callback when there's some error occured when fetching after the initial
  /// fetch
  _continuousError(dynamic e) {
    snapshot.error = e;
    snapshot.state = InfiniteScrollState.error;
    _inputEvent(snapshot);
  }

  /// Callback when there's fetch process
  _continuousLoading() {
    snapshot.state = InfiniteScrollState.loading;
    _inputEvent(snapshot);
  }

  Future<List<T>?> _getNewValue() async {
    if (_isFinish) return null;

    try {
      // Using completer for wait until the value is received from stream
      Completer<List<T>> result = Completer<List<T>>();

      final _data = snapshot.data;

      /// Lock the process
      _isFetching = true;

      if (_data.length == 0) loading();
      if (_data.length > 0) _continuousLoading();

      /// If there's a process before this, then cancel and create new process
      process?.cancel();

      /// Start the fetching process
      process = _callback!(_data.length).asStream().listen((res) {
        if (!result.isCompleted) result.complete(res);
      })
        ..onError((e) => result.completeError(e))
        ..onData((data) {
          if (!result.isCompleted) result.complete(data);
        });

      /// Await until the value completer is finish it's future
      var value = await result.future;

      /// Unlock the process
      _isFetching = false;

      /// Update state
      _finish(value);
      return value;
    } catch (e) {
      if (snapshot.data.isEmpty) {
        _isFetching = false;
        error(InfiniteScrollError(e));
        return null;
      }

      return _continuousError(e);
    }
  }

  /// Fetching the last value of given offset
  Future<bool> fetchLast() async {
    _isFinish = false;
    var res = await _getNewValue();
    if (res == null) {
      return false;
    }

    return true;
  }

  /// Reset InfiniteScrollController, useful if you want to integrate it
  /// with pull to refresh or something like that
  Future<bool> reset() async {
    loading();
    _isFinish = false;
    initialFetch = new Completer();
    snapshot = InfiniteScrollSnapshot(
      data: [],
      state: InfiniteScrollState.loading,
    );

    var res = await _getNewValue();

    if (res == null) {
      _continuousError("Error Because of Null");
      return false;
    }

    return true;
  }

  offsetCallbackHandler(double offset) {
    if (scrollController == null) throw "There's no ScrollController inside this Controller";

    double _maxExt = scrollController!.position.maxScrollExtent;
    double _thereshold = _scrollThereshold ?? _maxExt;

    bool _offsetExceeded = offset >= _thereshold;

    if (_offsetExceeded && !_isFetching) {
      _getNewValue();
    }
  }

  @override
  @mustCallSuper
  void dispose() {
    process?.cancel();
    stateController.close();
    _offsetController.close();
    _offsetStreamListener?.cancel();
    scrollController?.removeListener(scrollListener!);
    if (!_customScroll) scrollController?.dispose();
    super.dispose();
  }

  initialize(
    Future<List<T>> Function(int offset) callback, {
    double? offsetThereshold,
    ScrollController? controller,
  }) {
    // Cypage Loading
    loading();

    // Change is finished to false
    _isFinish = false;

    // Reset initial fetch
    initialFetch = new Completer();

    // Reset state snapshot
    snapshot = InfiniteScrollSnapshot(
      data: [],
      state: InfiniteScrollState.loading,
    );

    // Setup callback
    _callback = callback;

    // Check whether scrollcontroller is null or not, if null then
    // it need to construct it's own scrollcontroller
    if (scrollController == null) {
      _customScroll = controller != null;

      if (controller != null) scrollController = controller;
      if (controller == null) scrollController = new ScrollController();

      // Setup scroll listener
      scrollListener = () {
        if (stateController.isClosed) {
          scrollController?.removeListener(scrollListener!);
          return;
        }

        offsetIn.add(scrollController!.offset);
      };

      scrollController?.addListener(scrollListener!);

      _offsetStreamListener = offsetStream.listen(offsetCallbackHandler);
      _scrollThereshold = offsetThereshold;
    }

    _getNewValue();
  }
}

class InfiniteScrollError extends CypageError {
  InfiniteScrollError(error) : super(error);
}

class InfiniteScrollSnapshot<T> {
  T data;
  InfiniteScrollState state;
  dynamic error;

  InfiniteScrollSnapshot({
    required this.data,
    required this.state,
    this.error,
  });

  bool get isFetching => state == InfiniteScrollState.loading;
  bool get isErrorOccured => state == InfiniteScrollState.error;
}

enum InfiniteScrollState {
  error,
  loading,
  active,
}
