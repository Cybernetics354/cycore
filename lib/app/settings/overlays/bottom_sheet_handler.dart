part of cycore_app;

/// Abstract class to handle bottom sheet dialog
abstract class BottomSheetEvent {
  Future build(BuildContext context);

  static Future _defaultHander(
    BuildContext context,
    BottomSheetEvent handler,
  ) async {
    return await handler.build(context);
  }
}
