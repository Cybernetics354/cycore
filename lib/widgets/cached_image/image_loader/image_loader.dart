part of cached_image;

class ImageLoader {
  static BaseLoader loader({
    required String url,
    String? cacheKey,
    required DecoderCallback decode,
    required BaseCacheManager cacheManager,
    int? maxHeight,
    int? maxWidth,
    Map<String, String>? headers,
    Function? errorListener,
    required ImageRenderMethodForWeb imageRenderMethodForWeb,
    required Function evictImage,
    required CachedImageController controller,
  }) {
    switch (PlatformUtils.platformType.runtimeType) {
      case AndroidPlatform:
      case IOSPlatform:
        return _MobileImageLoader(
          cacheManager: cacheManager,
          controller: controller,
          decode: decode,
          evictImage: evictImage,
          imageRenderMethodForWeb: imageRenderMethodForWeb,
          url: url,
          cacheKey: cacheKey,
          errorListener: errorListener,
          headers: headers,
          maxHeight: maxHeight,
          maxWidth: maxWidth,
        );

      case WebPlatform:
        return _WebImageLoader(
          cacheManager: cacheManager,
          controller: controller,
          decode: decode,
          evictImage: evictImage,
          imageRenderMethodForWeb: imageRenderMethodForWeb,
          url: url,
          cacheKey: cacheKey,
          errorListener: errorListener,
          headers: headers,
          maxHeight: maxHeight,
          maxWidth: maxWidth,
        );

      default:
        throw UnimplementedError();
    }
  }
}
