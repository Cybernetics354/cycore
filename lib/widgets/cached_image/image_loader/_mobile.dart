part of cached_image;

class _MobileImageLoader extends BaseLoader {
  _MobileImageLoader({
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
  }) : super(
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

  @override
  Stream<ui.Codec> loadAsync() async* {
    try {
      assert(
        cacheManager is ImageCacheManager || (maxWidth == null && maxHeight == null),
        'To resize the image with a CacheManager the '
        'CacheManager needs to be an ImageCacheManager. maxWidth and '
        'maxHeight will be ignored when a normal CacheManager is used.',
      );

      final stream = cacheManager.getFileStream(
        url,
        withProgress: true,
        headers: headers,
        key: cacheKey,
      );

      await for (var result in stream) {
        if (result is DownloadProgress) {
          controller._fetchingState(
            bytesExpected: result.totalSize ?? 0,
            bytesReceive: result.downloaded,
          );
        }

        if (result is FileInfo) {
          controller._collectingState();

          var file = result.file;
          var bytes = await file.readAsBytes();
          var decoded = await decode(bytes);
          yield decoded;
        }
      }
    } catch (e) {
      // Depending on where the exception was thrown, the image cache may not
      // have had a chance to track the key in the cache at all.
      // Schedule a microtask to give the cache a chance to add the key.
      scheduleMicrotask(() {
        evictImage();
      });

      errorListener?.call();
      controller._errorState(e);
    }
  }
}
