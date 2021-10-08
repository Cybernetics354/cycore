part of cached_image;

class CachedImageStateSnapshot {
  CachedImageStates currentState;
  String? resolvedUrl;

  CachedImageStateSnapshot({
    required this.currentState,
    this.resolvedUrl,
  });
}
