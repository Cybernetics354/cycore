part of cycore_app;

class ResponsiveLayoutSettings {
  /// Used as breakpoint changes from Phone
  /// View to Tablet View, the default value
  /// is 786.0
  final double tabletBreakpoint;

  /// Used as breakpoint changes from Tablet View to Desktop
  /// View, the default value is 1224.0
  final double desktopBreakpoint;

  const ResponsiveLayoutSettings({
    this.tabletBreakpoint = 768.0,
    this.desktopBreakpoint = 1224.0,
  }) : assert(
          tabletBreakpoint <= desktopBreakpoint,
          "Desktop Breakpoint must be more than Tablet Breakpoint",
        );
}
