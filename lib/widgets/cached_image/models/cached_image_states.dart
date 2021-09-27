part of cached_image;

abstract class CachedImageStates {}

class IddleCachedImageState extends CachedImageStates {}

class InitiateCachedImageState extends CachedImageStates {}

class FetchingCachedImageState extends CachedImageStates {
  final ImageChunkEvent chunkEvent;

  FetchingCachedImageState({required this.chunkEvent});

  double get progress => chunkEvent.cumulativeBytesLoaded / (chunkEvent.expectedTotalBytes ?? 0.0);
}

class CollectingCachedImageState extends CachedImageStates {}

class DecodingCachedImageState extends CachedImageStates {}

class FinishCachedImageState extends CachedImageStates {}

class ErrorCachedImageState extends CachedImageStates {
  final dynamic exception;
  final StackTrace? stackTrace;

  ErrorCachedImageState(
    this.exception, {
    this.stackTrace,
  });
}
