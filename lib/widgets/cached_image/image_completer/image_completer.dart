part of cached_image;

class Testing extends ImageStreamCompleter {}

/// Slows down animations by this factor to help in development.
double get timeDilation => _timeDilation;
double _timeDilation = 1.0;

/// An ImageStreamCompleter with support for loading multiple images.
class MultiImageStreamCompleter extends ImageStreamCompleter {
  final CachedImageController controller;
  _CachedImageDecoding? dc;

  /// The constructor to create an MultiImageStreamCompleter. The [codec]
  /// should be a stream with the images that should be shown. The
  /// [chunkEvents] should indicate the [ImageChunkEvent]s of the first image
  /// to show.
  MultiImageStreamCompleter({
    required Stream<ui.Codec> codec,
    required double scale,
    required this.controller,
    Stream<ImageChunkEvent>? chunkEvents,
  }) {
    // setup the coding environment
    controller.decoding = _CachedImageDecoding(
      scale: scale,
    );

    // set the dc to controller decoding
    dc = controller.decoding;

    // listen the decoding to decode the asset
    controller.codecStream = codec.listen((event) {
      if (dc!.timer != null) {
        dc!.nextImageCoded = event;
        return;
      }

      _handleCodecReady(event);
    }, onError: (error, StackTrace stack) {
      controller._errorState(
        error,
        stackTrace: stack,
      );
    }, onDone: () {
      controller._finishState();
    });

    if (chunkEvents == null) return;

    chunkEvents.listen(
      reportImageChunkEvent,
      onError: (dynamic error, StackTrace stack) {
        controller._errorState(
          error,
          stackTrace: stack,
        );
      },
    );
  }

  void _switchToNewCodec() {
    dc!.frameEmitted = 0;
    dc!.timer = null;
    _handleCodecReady(dc!.nextImageCoded!);
    dc!.nextImageCoded = null;
  }

  void _handleCodecReady(ui.Codec codec) {
    dc!.codec = codec;
    controller._decodingState();

    if (!hasListeners) return;
    _decodeNextFrameAndSchedule();
  }

  void _handleAppFrame(Duration timestamp) {
    dc!.frameCallbackScheduled = false;
    if (!hasListeners) return;
    if (_isFirstFrame || _hasFrameDurationPassed(timestamp)) {
      _emitFrame(ImageInfo(image: dc!.nextFrame!.image, scale: dc!.scale));
      dc!.shownTimeStamp = timestamp;
      dc!.frameDuration = dc!.nextFrame!.duration;
      dc!.nextFrame = null;
      if (dc!.frameEmitted % dc!.codec!.frameCount == 0 && dc!.nextImageCoded != null) {
        return _switchToNewCodec();
      }

      final completedCycles = dc!.frameEmitted ~/ dc!.codec!.frameCount;
      if (dc!.codec!.repetitionCount == -1 || completedCycles <= dc!.codec!.repetitionCount) {
        _decodeNextFrameAndSchedule();
      }

      return;
    }

    final delay = dc!.frameDuration! - (timestamp - dc!.shownTimeStamp!);
    dc!.timer = Timer(delay * timeDilation, _scheduleAppFrame);
  }

  bool get _isFirstFrame => dc!.frameDuration == null;

  bool _hasFrameDurationPassed(Duration timestamp) {
    return timestamp - dc!.shownTimeStamp! >= dc!.frameDuration!;
  }

  Future<void> _decodeNextFrameAndSchedule() async {
    try {
      dc!.nextFrame = await dc!.codec!.getNextFrame();
    } catch (e) {
      controller._errorState(e);
      return;
    }

    if (dc!.codec!.frameCount != 1) return _scheduleAppFrame();

    // ImageStreamCompleter listeners removed while waiting for next frame to
    // be decoded.
    // There's no reason to emit the frame without active listeners.
    if (!hasListeners) return;

    // This is not an animated image, just return it and don't schedule more
    // frames.
    _emitFrame(ImageInfo(
      image: dc!.nextFrame!.image,
      scale: dc!.scale,
    ));
    return;
  }

  void _scheduleAppFrame() {
    if (dc!.frameCallbackScheduled) {
      return;
    }
    dc!.frameCallbackScheduled = true;
    SchedulerBinding.instance?.scheduleFrameCallback(_handleAppFrame);
  }

  void _emitFrame(ImageInfo imageInfo) {
    setImage(imageInfo);
    dc!.frameEmitted += 1;
  }

  @override
  void addListener(ImageStreamListener listener) {
    if (!hasListeners && dc!.codec != null) _decodeNextFrameAndSchedule();
    super.addListener(listener);
  }

  @override
  void removeListener(ImageStreamListener listener) {
    super.removeListener(listener);
    if (!hasListeners) {
      dc!.timer?.cancel();
      dc!.timer = null;
    }
  }
}
