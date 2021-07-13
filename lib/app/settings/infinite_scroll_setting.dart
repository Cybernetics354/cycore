part of cycore_app;

class InfiniteScrollSettings {
  Widget Function(BuildContext) onEmptyBuilder;
  Widget Function(BuildContext) loadingBuilder;
  Widget Function(BuildContext, CypageError?) onErrorBuilder;

  InfiniteScrollSettings({
    Widget Function(BuildContext)? onEmptyBuilder,
    Widget Function(BuildContext)? loadingBuilder,
    Widget Function(BuildContext, CypageError?)? onErrorBuilder,
  })  : onEmptyBuilder = onEmptyBuilder ?? _emptyBuilder,
        loadingBuilder = loadingBuilder ?? _loadingBuilder,
        onErrorBuilder = onErrorBuilder ?? _errorBuilder;

  static Widget _emptyBuilder(BuildContext context) {
    return Center(
      child: Text(
        "There's no item",
        textAlign: TextAlign.center,
      ),
    );
  }

  static Widget _loadingBuilder(BuildContext context) {
    return Container(
      width: context.screenWidth,
      padding: EdgeInsets.all(30.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static Widget _errorBuilder(
    BuildContext context,
    CypageError? error,
  ) {
    return Container(
      width: context.screenWidth,
      padding: EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Terjadi kesalahan"),
          ],
        ),
      ),
    );
  }
}
