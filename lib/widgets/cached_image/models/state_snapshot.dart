part of cached_image;

class CachedImageStateSnapshot {
  CachedImageStates currentState;
  _WidgetConfiguration? widgetConf;

  CachedImageStateSnapshot({required this.currentState, this.widgetConf});
}
