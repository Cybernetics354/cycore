library cycore_app;

import 'package:cycore/widgets/cypage/cypage.dart';
import 'package:flutter/material.dart';

part 'settings/responsive_layout_settings.dart';
part 'settings/cypage_settings.dart';

class CycoreApp extends InheritedWidget {
  CycoreApp({
    Key? key,
    required this.child,
    this.responsiveLayoutSettings = const ResponsiveLayoutSettings(),
    CypageSettings? cypageSettings,
  })  : cypageSettings = cypageSettings ?? CypageSettings(),
        super(
          key: key,
          child: child,
        );

  /// Use this to set global [ResponsiveLayout] Widget setting
  final ResponsiveLayoutSettings responsiveLayoutSettings;

  /// Cypage global setting
  final CypageSettings cypageSettings;
  final Widget child;

  static CycoreApp? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CycoreApp>();
  }

  @override
  bool updateShouldNotify(CycoreApp oldWidget) {
    return true;
  }
}
