part of cached_image;

class _WebImageLoader extends BaseLoader {
  _WebImageLoader({
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
  Stream<ui.Codec> loadAsync() {
    switch (imageRenderMethodForWeb) {
      case ImageRenderMethodForWeb.httpGet:
        return _loadAsyncHttpGet();

      // case ImageRenderMethodForWeb.htmlImage:
      //   return _loadAsyncHtmlImage(
      //     url,
      //     decode,
      //     controller,
      //   ).asStream();

      default:
        throw UnimplementedError();
    }
  }

  Stream<ui.Codec> _loadAsyncHttpGet() async* {
    try {
      final fileStream = cacheManager.getFileStream(
        url,
        withProgress: true,
        headers: headers,
      );

      await for (var result in fileStream) {
        if (result is DownloadProgress) {
          controller._fetchingState(
            bytesExpected: result.totalSize,
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

  // Future<ui.Codec> _loadAsyncHtmlImage(
  //   String url,
  //   DecoderCallback decode,
  //   CachedImageController controller,
  // ) {
  //   final resolved = Uri.base.resolve(url);

  //   // ignore: undefined_function
  //   return ui.webOnlyInstantiateImageCodecFromUrl(
  //     resolved,
  //     chunkCallback: (int bytes, int total) {
  //       controller.fetchingState(
  //         bytesExpected: total,
  //         bytesReceive: bytes,
  //       );
  //     },
  //   ) as Future<ui.Codec>;
  // }
}
