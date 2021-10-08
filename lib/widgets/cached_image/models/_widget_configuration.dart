part of cached_image;

class CachedImageWidgetConfiguration {
  bool? evict;
  AlignmentGeometry? alignment;
  Rect? centerSlice;
  Color? color;
  BlendMode? blendMode;
  bool? excludeFromSemantics;
  FilterQuality? filterQuality;
  BoxFit? fit;
  ImageFrameBuilder? frameBuilder;
  double? height;
  double? width;
  bool? isAntiAlias;
  bool? isGaplessPlayback;
  bool? matchTextDirection;
  ImageRepeat? imageRepeat;
  String? semanticLabel;

  CachedImageWidgetConfiguration({
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
