part of cached_image;

/// Function which is called after loading the image failed.
typedef ErrorListener = void Function();

/// IO implementation of the CachedNetworkImageProvider; the ImageProvider to
/// load network images using a cache.
class CachedImageProvider extends ImageProvider<CachedImageProvider> {
  final CachedImageController controller;

  /// CacheManager from which the image files are loaded.
  final BaseCacheManager? cacheManager;

  /// Web url of the image to load
  final String url;

  /// Cache key of the image to cache
  final String? cacheKey;

  /// Scale of the image
  final double scale;

  /// Listener to be called when images fails to load.
  final ErrorListener? errorListener;

  /// Set headers for the image provider, for example for authentication
  final Map<String, String>? headers;

  /// Maximum height of the loaded image. If not null and using an
  /// [ImageCacheManager] the image is resized on disk to fit the height.
  final int? maxHeight;

  /// Maximum width of the loaded image. If not null and using an
  /// [ImageCacheManager] the image is resized on disk to fit the width.
  final int? maxWidth;

  /// Render option for images on the web platform.
  final ImageRenderMethodForWeb imageRenderMethodForWeb;

  /// Creates an ImageProvider which loads an image from the [url], using the [scale].
  /// When the image fails to load [errorListener] is called.
  const CachedImageProvider(
    this.url, {
    this.maxHeight,
    this.maxWidth,
    this.scale = 1.0,
    this.errorListener,
    this.headers,
    this.cacheManager,
    this.cacheKey,
    this.imageRenderMethodForWeb = ImageRenderMethodForWeb.htmlImage,
    required this.controller,
  });

  @override
  Future<CachedImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<CachedImageProvider>(this);
  }

  @override
  ImageStreamCompleter load(CachedImageProvider key, DecoderCallback decode) {
    return MultiImageStreamCompleter(
      controller: controller,
      codec: _loadAsync(key, controller, decode),
      chunkEvents: controller.chunkEvent,
      scale: key.scale,
    );
  }

  Stream<ui.Codec> _loadAsync(
    CachedImageProvider key,
    CachedImageController controller,
    DecoderCallback decode,
  ) {
    assert(key == this);
    return ImageLoader.loader(
      url: url,
      cacheKey: cacheKey,
      decode: decode,
      cacheManager: cacheManager ?? DefaultCacheManager(),
      maxHeight: maxHeight,
      maxWidth: maxWidth,
      headers: headers,
      errorListener: errorListener,
      imageRenderMethodForWeb: imageRenderMethodForWeb,
      evictImage: () => PaintingBinding.instance?.imageCache?.evict(key),
      controller: controller,
    ).loadAsync();
  }

  @override
  bool operator ==(dynamic other) {
    if (other is CachedImageProvider) {
      final _key = cacheKey ?? url;
      final _otherKey = other.cacheKey ?? other.url;
      final _hasSameKey = _key == _otherKey;

      return _hasSameKey &&
          scale == other.scale &&
          maxHeight == other.maxHeight &&
          maxWidth == other.maxWidth;
    }
    return false;
  }

  @override
  int get hashCode => hashValues(cacheKey ?? url, scale, maxHeight, maxWidth);

  @override
  String toString() => '$runtimeType("$url", scale: $scale)';
}
