part of extension;

extension BuildContextExtension on BuildContext {
  /// Returns [CypageController] from current context
  CypageController? get cypageController => CypageProvider.of(this)?.controller;

  /// Call bottom sheet that handled by [bottomSheetHandler]
  Future<T?> showBottomSheet<T>(BottomSheetEvent handler) async {
    final _app = CycoreApp.of(this);
    if (_app == null) throw "There's no CycoreApp within Widget Tree";

    return await _app.overlayHandler.bottomSheet(this, handler);
  }

  /// Call dialog that handled by [dialogHandler]
  Future<T?> showDialog<T>(DialogEvent handler) async {
    final _app = CycoreApp.of(this);
    if (_app == null) throw "There's no CycoreApp within Widget Tree";

    return await _app.overlayHandler.dialog(this, handler);
  }

  /// To get a [MediaQuery] directly.
  MediaQueryData get mq => MediaQuery.of(this);

  /// Get MediaQuery Screen Size
  Size get screenSize => mq.size;

  /// Get MediaQuery Screen Density
  double get screenDensity => mq.devicePixelRatio;

  /// Get MediaQuery Screen Padding
  EdgeInsets get screenPadding => mq.padding;

  /// Get MediaQuery Screen Width
  double get screenWidth => mq.size.width;

  /// Get MediaQuery Screen Height
  double get screenHeight => mq.size.height;

  /// Get MediaQuery Screen Width in percentage
  double get percentWidth => screenWidth / 100;

  /// Get MediaQuery Screen height in percentage
  double get percentHeight => screenHeight / 100;

  /// Get MediaQuery safearea padding horizontally
  double get _safeAreaHorizontal => mq.padding.left + mq.padding.right;

  /// Get MediaQuery safearea padding vertically
  double get _safeAreaVertical => mq.padding.top + mq.padding.bottom;

  /// Get MediaQuery Screen Width in percentage including safe area calculation.
  double get safePercentWidth => (screenWidth - _safeAreaHorizontal) / 100;

  /// Get MediaQuery Screen Height in percentage including safe area calculation.
  double get safePercentHeight => (screenHeight - _safeAreaVertical) / 100;

  ///Returns Orientation using [MediaQuery]
  Orientation get orientation => mq.orientation;

  /// Returns if Orientation is landscape
  bool get isLandscape => orientation == Orientation.landscape;

  /// Extension for getting Theme
  ThemeData get theme => Theme.of(this);

  /// Extension for getting [CupertinoThemeData]
  CupertinoThemeData get cupertinoTheme => CupertinoTheme.of(this);

  /// Extension for getting textTheme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Extension for getting textTheme
  TextStyle? get captionStyle => Theme.of(this).textTheme.caption;

  /// Get the color scheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// A secondary color provides more ways to accent and distinguish your product. Having a secondary color is optional, and should be applied sparingly to accent select parts of your UI.
  ///
  /// If you don’t have a secondary color, your primary color can also be used to accent elements.
  ///
  /// Secondary colors are best for:
  ///
  /// Floating action buttons
  /// Selection controls, like sliders and switches
  /// Highlighting selected text
  /// Progress bars
  /// Links and headlines
  Color get secondaryColor => colorScheme.secondary;

  ///
  /// A primary color is the color displayed most frequently across your app's screens and components.
  ///
  Color get primaryColor => colorScheme.primary;

  /// Darker version of the primary color
  Color get primaryVariant => colorScheme.primaryVariant;

  /// The background color appears behind scrollable content.
  Color get backgroundColor => colorScheme.background;

  /// Surface colors affect surfaces of components, such as cards, sheets, and menus.
  Color get surfaceColor => colorScheme.surface;

  /// Error color indicates errors in components, such as invalid text in a text field.
  Color get errorColor => colorScheme.error;

  ///
  /// The default brightness of the [Theme].
  ///
  Brightness get brightness => brightness;

  /// Content on top of primary color
  Color get onPrimary => colorScheme.onPrimary;

  /// Content color on top of secondary color
  Color get onSecondary => colorScheme.onSecondary;

  /// Content color on top of surface color
  Color get onSurface => colorScheme.onSurface;

  /// Content color on top of error color
  Color get onError => colorScheme.onError;

  /// Content color on top of background color
  Color get onBackground => colorScheme.onBackground;

  /// Extension for navigation to next page
  /// Returns The state from the closest instance of this class that encloses the given context.
  ///
  /// It is used for routing in flutter
  ///
  NavigatorState? get navigator => Navigator.of(this);

  ///
  /// Pushes the built widget to the screen using the material fade in animation
  ///
  /// Will return a value when the built widget calls [pop]
  ///
  Future<T?> push<T>(WidgetBuilder builder) async {
    return await navigator!.push<T>(MaterialPageRoute(builder: builder));
  }

  ///
  /// Removes the top most Widget in the navigator's stack
  ///
  /// Will return the [result] to the caller of [push]
  ///
  void pop<T>([T? result]) => navigator!.pop<T>(result);

  ///
  /// Pushes the built widget to the screen using the material fade in animation
  ///
  void nextPage(Widget page, {bool maintainState = true}) =>
      _nextPage(context: this, page: page, maintainState: maintainState);

  /// Pushes and replacing the built widget to the screen using the material fade in animation
  void nextReplacementPage(Widget page, {bool maintainState = true}) =>
      _nextReplacementPage(context: this, page: page, maintainState: maintainState);

  /// Removing all the widgets till defined rule, and pushes the built widget to the screen using the material fade in animation
  void nextAndRemoveUntilPage(Widget page) => _nextAndRemoveUntilPage(context: this, page: page);

  /// Action Extension
  bool? invokeAction(Intent intent) => Actions.invoke(this, intent) as bool?;

  /// Returns The state from the closest instance of this class that encloses the given context.
  /// It is used for validating forms
  FormState? get form => Form.of(this);

  ///
  /// Returns The current [Locale] of the app as specified in the [Localizations] widget.
  ///
  Locale? get locale => Localizations.localeOf(this);

  /// Returns The state from the closest instance of this class that encloses the given context.
  ///
  /// It is used for showing widgets on top of everything.
  ///
  OverlayState? get overlay => Overlay.of(this);

  ///
  /// Insert the given widget into the overlay.
  /// The newly inserted widget will always be at the top.
  ///
  OverlayEntry addOverlay(WidgetBuilder builder) {
    final entry = OverlayEntry(builder: builder);
    overlay!.insert(entry);
    return entry;
  }

  ///
  /// Returns the closest instance of [ScaffoldState] in the widget tree,
  /// which can be use to get information about that scaffold.
  ///
  /// If there is no [Scaffold] in scope, then this will throw an exception.
  ///
  ScaffoldState get scaffold => Scaffold.of(this);

  /// Clear current context focus, like keyboar etc
  clearFocus() {
    FocusScopeNode focus = FocusScope.of(this);

    if (!focus.hasPrimaryFocus) {
      focus.unfocus();
    }
  }
}

Future<void> _nextPage({
  required BuildContext context,
  required Widget page,
  bool maintainState = true,
}) async =>
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
          maintainState: maintainState,
        ));

Future<void> _nextReplacementPage({
  required BuildContext context,
  required Widget page,
  bool maintainState = true,
}) async =>
    await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => page,
          maintainState: maintainState,
        ));

Future<void> _nextAndRemoveUntilPage({
  required BuildContext context,
  required Widget page,
}) async =>
    await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => page),
      (route) => false,
    );
