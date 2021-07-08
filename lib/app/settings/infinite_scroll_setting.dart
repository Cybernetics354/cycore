part of cycore_app;

class InfiniteScrollSettings {
  Widget Function(BuildContext) onEmptyBuilder;

  InfiniteScrollSettings({
    Widget Function(BuildContext)? onEmptyBuilder,
  }) : onEmptyBuilder = onEmptyBuilder ?? _emptyBuilder;

  static Widget _emptyBuilder(BuildContext context) {
    return Center(
      child: Text(
        "There's no item",
        textAlign: TextAlign.center,
      ),
    );
  }
}
