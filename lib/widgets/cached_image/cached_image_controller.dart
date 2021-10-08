part of cached_image;

class CachedImageController {
  _CachedImageDecoding? decoding;
  CachedImageStateSnapshot snapshot = CachedImageStateSnapshot(
    currentState: IddleCachedImageState(),
  );

  StreamSubscription<ui.Codec>? codecStream;

  /// Stream Controller for [name]
  final BehaviorSubject<CachedImageStateSnapshot> stateController =
      new BehaviorSubject<CachedImageStateSnapshot>();

  /// Stream pipe for [stateController]
  Stream<CachedImageStateSnapshot> get stateStream => stateController.stream;

  /// Stream sink for [stateController]
  StreamSink<CachedImageStateSnapshot> get inState => stateController.sink;

  Stream<ImageChunkEvent> get chunkEvent {
    return stateController.map((event) {
      final _currentState = event.currentState;
      if (!(_currentState is FetchingCachedImageState))
        return ImageChunkEvent(
          cumulativeBytesLoaded: 0,
          expectedTotalBytes: 0,
        );

      return _currentState.chunkEvent;
    });
  }

  _emit({
    CachedImageStates? state,
    String? resolvedUrl,
  }) {
    final CachedImageStateSnapshot _snapshot = CachedImageStateSnapshot(
      currentState: snapshot.currentState,
      resolvedUrl: snapshot.resolvedUrl,
    );

    if (stateController.isClosed) return;

    if (state != null) _snapshot.currentState = state;
    if (resolvedUrl != null) _snapshot.resolvedUrl = resolvedUrl;

    snapshot = _snapshot;
    inState.add(snapshot);
  }

  _iddleState() => _emit(state: IddleCachedImageState());

  _initiateState(String resolvedUrl) => _emit(
        state: InitiateCachedImageState(),
        resolvedUrl: resolvedUrl,
      );

  _fetchingState({
    int? bytesReceive,
    int? bytesExpected,
  }) {
    return _emit(
      state: FetchingCachedImageState(
        chunkEvent: ImageChunkEvent(
          cumulativeBytesLoaded: bytesReceive ?? 0,
          expectedTotalBytes: bytesReceive,
        ),
      ),
    );
  }

  _collectingState() => _emit(state: CollectingCachedImageState());

  _decodingState() => _emit(state: DecodingCachedImageState());

  _finishState() => _emit(state: FinishCachedImageState());

  _errorState(dynamic exception, {StackTrace? stackTrace}) => _emit(
        state: ErrorCachedImageState(
          exception,
          stackTrace: stackTrace,
        ),
      );

  reload() {
    _iddleState();
  }

  _initialSetup(
    BuildContext context,
    CachedImageSettings setting,
    String url, {
    bool? shouldEvict = false,
  }) async {
    try {
      var rUrl = await resolveUrl(context, setting, url);
      if (shouldEvict ?? false) _evictImage(rUrl);
      _initiateState(rUrl);
    } catch (e) {
      _errorState(e);
    }
  }

  Future<bool> _evictImage(String url) async {
    final _cacheManager = DefaultCacheManager();
    await _cacheManager.removeFile(
      url,
    );
    return true;
  }

  Future<String> resolveUrl(
    BuildContext context,
    CachedImageSettings setting,
    String url,
  ) async {
    return await setting.urlResolve(context, url);
  }

  void dispose() {
    stateController.close();
    codecStream?.cancel();
  }

  CachedImageController() {
    _iddleState();
  }
}
