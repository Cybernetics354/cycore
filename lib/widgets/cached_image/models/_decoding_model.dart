part of cached_image;

class _CachedImageDecoding {
  final double scale;
  ui.Codec? codec;
  ui.Codec? nextImageCoded;
  ui.FrameInfo? nextFrame;
  // When the current was first shown.
  Duration? shownTimeStamp;
  // The requested duration for the current frame;
  Duration? frameDuration;
  // How many frames have been emitted so far.
  int frameEmitted = 0;
  Timer? timer;
  // Used to guard against registering multiple _handleAppFrame callbacks for the same frame.
  bool frameCallbackScheduled = false;

  _CachedImageDecoding({
    required this.scale,
  });
}
