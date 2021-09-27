part of cached_image;

/// Render options for images on the web platform.
enum ImageRenderMethodForWeb {
  /// HtmlImage uses a default web image including default browser caching.
  /// This is the recommended and default choice.
  htmlImage,

  /// HttpGet uses an http client to fetch an image. It enables the use of
  /// headers, but loses some default web functionality.
  httpGet,
}

/// ImageLoader class to load images differently on various platforms.
abstract class BaseLoader {
  String url;
  String? cacheKey;
  DecoderCallback decode;
  BaseCacheManager cacheManager;
  int? maxHeight;
  int? maxWidth;
  Map<String, String>? headers;
  Function? errorListener;
  ImageRenderMethodForWeb imageRenderMethodForWeb;
  Function evictImage;
  CachedImageController controller;

  BaseLoader({
    required this.url,
    this.cacheKey,
    required this.decode,
    required this.cacheManager,
    this.maxHeight,
    this.maxWidth,
    this.headers,
    this.errorListener,
    required this.imageRenderMethodForWeb,
    required this.evictImage,
    required this.controller,
  });

  /// loads the images async and gives the resulted codecs on a Stream. The
  /// Stream gives the option to show multiple images after each other.
  Stream<ui.Codec> loadAsync();
}
