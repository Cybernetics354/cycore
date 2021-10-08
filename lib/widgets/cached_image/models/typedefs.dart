part of cached_image;

/// Used for resolving url image, example when you need to resolve the url
typedef CachedImageURLResolve = String Function(
  BuildContext context,
  String url,
);

/// Used to build the widget
typedef CachedImageBuilder = Widget Function(
  BuildContext context,
  CachedImageStateSnapshot snapshot,
  ImageProvider image,
  String url,
);
