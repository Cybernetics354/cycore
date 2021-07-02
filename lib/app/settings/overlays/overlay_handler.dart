part of cycore_app;

/// Create custom OverlayHandler with Extending this
abstract class OverlayHandler {
  /// Handle incoming dialog event from [context.showDialog]
  @mustCallSuper
  Future dialog(
    BuildContext context,
    DialogEvent handler,
  ) async {}

  /// Handle incoming dialog event from [context.showBottomSheet]
  @mustCallSuper
  Future bottomSheet(
    BuildContext context,
    BottomSheetEvent handler,
  ) async {}
}

/// Default OverlayHandler
class DefaultOverlayHandler extends OverlayHandler {
  @override
  Future bottomSheet(
    BuildContext context,
    BottomSheetEvent handler,
  ) async {
    super.bottomSheet(context, handler);
    return await BottomSheetEvent._defaultHander(
      context,
      handler,
    );
  }

  @override
  Future dialog(
    BuildContext context,
    DialogEvent handler,
  ) async {
    super.dialog(context, handler);
    return await DialogEvent._defaultHander(
      context,
      handler,
    );
  }
}
