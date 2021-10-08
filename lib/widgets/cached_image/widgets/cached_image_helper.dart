part of cached_image;

class CachedImageHelper extends StatelessWidget {
  final CachedImageStateSnapshot snapshot;
  final ImageProvider image;
  final String url;

  final Duration? transitionDuration;
  final Duration? reverseTransitionDuration;
  final Widget Function(Widget, Animation<double>)? transitionBuilder;
  final Widget Function(Widget?, List<Widget>)? layoutBuilder;
  final Curve? switchInCurve;
  final Curve? switchOutCurve;

  final Widget Function(BuildContext)? onLoading;
  final Widget Function(BuildContext, FetchingCachedImageState)? onDownload;
  final Widget Function(BuildContext, ErrorCachedImageState)? onError;
  final Widget Function(BuildContext, ImageProvider)? builder;

  const CachedImageHelper({
    Key? key,
    required this.snapshot,
    required this.image,
    required this.url,
    this.builder,
    this.onError,
    this.onLoading,
    this.onDownload,
    this.transitionBuilder,
    this.layoutBuilder,
    this.transitionDuration,
    this.reverseTransitionDuration,
    this.switchInCurve,
    this.switchOutCurve,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _setting = CycoreApp.of(context)!.cachedImageSettings;

    bool _shouldStartBuild = !(snapshot.currentState is IddleCachedImageState);
    Widget? _overlayWidget = SizedBox(
      key: ValueKey("initial"),
    );

    final _builder = builder != null
        ? builder!(context, image)
        : _setting.builder(context, snapshot, image, url);

    switch (snapshot.currentState.runtimeType) {
      case IddleCachedImageState:
      case CollectingCachedImageState:
      case DecodingCachedImageState:
      case InitiateCachedImageState:
        {
          Widget _render = onLoading != null
              ? onLoading!(context)
              : _setting.onLoading(
                  context,
                  url,
                );

          _overlayWidget = Container(
            key: ValueKey(CachedImageBuilderWidgetKeys.loading),
            child: _render,
          );

          break;
        }

      case FetchingCachedImageState:
        {
          Widget _render = onDownload != null
              ? onDownload!(context, (snapshot.currentState as FetchingCachedImageState))
              : _setting.onDownloading(
                  context,
                  (snapshot.currentState as FetchingCachedImageState),
                  url,
                );

          _overlayWidget = Container(
            key: ValueKey(CachedImageBuilderWidgetKeys.downloading),
            child: _render,
          );

          break;
        }

      case ErrorCachedImageState:
        Widget _render = onError != null
            ? onError!(context, (snapshot.currentState as ErrorCachedImageState))
            : _setting.onError(
                context,
                (snapshot.currentState as ErrorCachedImageState),
                url,
              );

        _overlayWidget = Container(
          key: ValueKey(CachedImageBuilderWidgetKeys.error),
          child: _render,
        );
        break;

      default:
        _overlayWidget = SizedBox(
          key: ValueKey(CachedImageBuilderWidgetKeys.finish),
        );
    }

    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: _shouldStartBuild ? _builder : SizedBox(),
        ),
        Positioned(
          top: 0,
          left: 0,
          bottom: 0,
          right: 0,
          child: Center(
            child: AnimatedSwitcher(
              duration: transitionDuration ?? Duration(milliseconds: 1000),
              transitionBuilder: transitionBuilder ??
                  (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
              switchInCurve: switchInCurve ?? Curves.ease,
              switchOutCurve: switchInCurve ?? Curves.ease,
              child: _overlayWidget,
            ),
          ),
        ),
      ],
    );
  }
}

enum CachedImageBuilderWidgetKeys {
  loading,
  downloading,
  error,
  finish,
}
