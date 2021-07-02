part of cycore_app;

/// Abstract class to handle basic dialog
abstract class DialogEvent {
  Future build(BuildContext context);

  static Future _defaultHander(
    BuildContext context,
    DialogEvent handler,
  ) async {
    return await handler.build(context);
  }
}
