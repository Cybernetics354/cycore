library cycore_app;

import 'package:cycore/cycore.dart';
import 'package:cycore/widgets/cypage/cypage.dart';
import 'package:flutter/material.dart';

part 'settings/responsive_layout_settings.dart';
part 'settings/cypage_settings.dart';
part 'settings/overlays/bottom_sheet_handler.dart';
part 'settings/overlays/dialog_handler.dart';
part 'settings/overlays/overlay_handler.dart';
part 'settings/infinite_scroll_setting.dart';

class CycoreApp extends InheritedWidget {
  CycoreApp({
    Key? key,
    required this.child,
    this.responsiveLayoutSettings = const ResponsiveLayoutSettings(),
    OverlayHandler? overlayHandler,
    CypageSettings? cypageSettings,
    InfiniteScrollSettings? infiniteScrollSettings,
  })  : cypageSettings = cypageSettings ?? CypageSettings(),
        overlayHandler = overlayHandler ?? DefaultOverlayHandler(),
        infiniteScrollSettings = infiniteScrollSettings ?? InfiniteScrollSettings(),
        super(
          key: key,
          child: child,
        );

  /// Use this to set global [ResponsiveLayout] Widget setting
  final ResponsiveLayoutSettings responsiveLayoutSettings;

  /// Cypage global setting
  final CypageSettings cypageSettings;

  /// Handle overlays from context
  final OverlayHandler overlayHandler;

  final InfiniteScrollSettings infiniteScrollSettings;

  final Widget child;

  static CycoreApp? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CycoreApp>();
  }

  @override
  bool updateShouldNotify(CycoreApp oldWidget) {
    return true;
  }
}
