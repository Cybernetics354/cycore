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
    _WidgetConfiguration? widgetConf,
  }) {
    final CachedImageStateSnapshot _snapshot = CachedImageStateSnapshot(
      currentState: snapshot.currentState,
      widgetConf: snapshot.widgetConf,
    );

    if (stateController.isClosed) return;

    if (state != null) _snapshot.currentState = state;
    if (widgetConf != null) _snapshot.widgetConf = widgetConf;

    snapshot = _snapshot;
    inState.add(snapshot);
  }

  _iddleState() => _emit(state: IddleCachedImageState());

  _initiateState() => _emit(state: InitiateCachedImageState());

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

  setWidget({
    String? url,
    bool? evict,
    AlignmentGeometry? alignment,
    Rect? centerSlice,
    Color? color,
    BlendMode? blendMode,
    bool? excludeFromSemantics,
    FilterQuality? filterQuality,
    BoxFit? fit,
    ImageFrameBuilder? frameBuilder,
    double? height,
    double? width,
    bool? isAntiAlias,
    bool? isGaplessPlayback,
    bool? matchTextDirection,
    ImageRepeat? imageRepeat,
    String? semanticLabel,
  }) {
    final _current = snapshot.widgetConf;

    if (_current == null) throw "The current snapshot is null";

    final _WidgetConfiguration _new = _WidgetConfiguration(
      url: url ?? _current.url,
      alignment: alignment ?? _current.alignment,
      blendMode: blendMode ?? _current.blendMode,
      centerSlice: centerSlice ?? _current.centerSlice,
      color: color ?? _current.color,
      evict: evict ?? _current.evict,
      excludeFromSemantics: excludeFromSemantics ?? _current.excludeFromSemantics,
      filterQuality: filterQuality ?? _current.filterQuality,
      fit: fit ?? _current.fit,
      frameBuilder: frameBuilder ?? _current.frameBuilder,
      height: height ?? _current.height,
      imageRepeat: imageRepeat ?? _current.imageRepeat,
      isAntiAlias: isAntiAlias ?? _current.isAntiAlias,
      isGaplessPlayback: isGaplessPlayback ?? _current.isGaplessPlayback,
      matchTextDirection: matchTextDirection ?? _current.matchTextDirection,
      semanticLabel: semanticLabel ?? _current.semanticLabel,
      width: width ?? _current.width,
    );

    _emit(widgetConf: _new);
  }

  Future<bool> _evictImage() async {
    final _shouldEvict = snapshot.widgetConf!.evict;

    if (!_shouldEvict) return false;
    final _cacheManager = DefaultCacheManager();
    await _cacheManager.removeFile(
      snapshot.widgetConf!.url,
    );
    return true;
  }

  void dispose() {
    stateController.close();
    codecStream?.cancel();
  }

  CachedImageController() {
    _iddleState();
  }
}
