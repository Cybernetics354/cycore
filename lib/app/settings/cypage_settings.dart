part of cycore_app;

class CypageSettings {
  /// Default View for onLoading cypage
  final Widget Function(BuildContext, CypageSnapshot) onLoading;

  /// Default view for onError cypage
  final Widget Function(BuildContext, CypageSnapshot) onError;

  /// Default transition between states in cypage
  /// has default transition of vertical offset and fade in
  final Widget Function(Widget, Animation<double>) transitionBuilder;

  /// Default curve transition on cypage
  /// has default curve of [Curves.ease]
  final Curve curve;

  /// Default transition duration on cypage
  /// has default value of [Duration(milliseconds: 400)]
  final Duration duration;

  CypageSettings({
    Widget Function(BuildContext, CypageSnapshot)? onError,
    Widget Function(BuildContext, CypageSnapshot)? onLoading,
    Widget Function(Widget, Animation<double>)? transitionBuilder,
    Curve? curve,
    Duration? duration,
  })  : onLoading = onLoading ?? _loading,
        curve = curve ?? Curves.ease,
        transitionBuilder = transitionBuilder ?? _transition,
        duration = duration ?? Duration(milliseconds: 400),
        onError = onError ?? _error;

  static Widget _loading(
    BuildContext context,
    CypageSnapshot snapshot,
  ) {
    return Center(
      key: ValueKey("loading"),
      child: CircularProgressIndicator(),
    );
  }

  static Widget _error(
    BuildContext context,
    CypageSnapshot snapshot,
  ) {
    return Center(
      key: ValueKey("error"),
      child: Text(
        snapshot.error.toString(),
        textAlign: TextAlign.center,
      ),
    );
  }

  static Widget _transition(
    Widget child,
    Animation<double> animation,
  ) {
    final _slide = Tween<Offset>(
      begin: Offset(0, 0.05),
      end: Offset(0, 0),
    ).animate(
      animation,
    );

    return SlideTransition(
      position: _slide,
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
