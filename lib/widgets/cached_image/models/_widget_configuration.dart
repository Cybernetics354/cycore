part of cached_image;

class _WidgetConfiguration {
  final String url;
  final bool evict;
  final AlignmentGeometry? alignment;
  final Rect? centerSlice;
  final Color? color;
  final BlendMode? blendMode;
  final bool? excludeFromSemantics;
  final FilterQuality? filterQuality;
  final BoxFit? fit;
  final ImageFrameBuilder? frameBuilder;
  final double? height;
  final double? width;
  final bool? isAntiAlias;
  final bool? isGaplessPlayback;
  final bool? matchTextDirection;
  final ImageRepeat? imageRepeat;
  final String? semanticLabel;

  _WidgetConfiguration({
    required this.url,
    this.evict = false,
    this.alignment,
    this.blendMode,
    this.centerSlice,
    this.color,
    this.excludeFromSemantics,
    this.filterQuality,
    this.fit,
    this.frameBuilder,
    this.height,
    this.imageRepeat,
    this.isAntiAlias,
    this.isGaplessPlayback,
    this.matchTextDirection,
    this.semanticLabel,
    this.width,
  });
}
