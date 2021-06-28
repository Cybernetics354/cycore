library reponsive_container;

import 'package:cycore/app/cycore_app.dart';
import 'package:flutter/material.dart';

class ResponsiveContainer extends StatelessWidget {
  /// Basic Builder, the builder apply to Smartphone, and if there's no
  /// Builder upper, then use this builder as a default
  final Widget Function(BuildContext) builder;

  /// Tablet view builder, if null then return [builder]
  final Widget Function(BuildContext)? tabletBuilder;

  /// Desktop view builder, if null then return [tabletBuilder] if [tabletBuilder] is
  /// not null, and if null then return [builder]
  final Widget Function(BuildContext)? desktopBuilder;
  const ResponsiveContainer({
    Key? key,
    this.tabletBuilder,
    this.desktopBuilder,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        final _conf = CycoreApp.of(context)?.responsiveLayoutSettings;
        if (_conf == null) throw "There's No Cycore App Within Widget Tree";

        final double _w = constraint.maxWidth;

        if (_w < _conf.tabletBreakpoint) {
          return builder(context);
        }

        if (_w >= _conf.tabletBreakpoint && _w < _conf.desktopBreakpoint) {
          var _build = tabletBuilder;
          _build ??= builder;

          return _build(context);
        }

        if (_w >= _conf.desktopBreakpoint) {
          var _build = desktopBuilder;
          _build ??= tabletBuilder;
          _build ??= builder;

          return _build(context);
        }

        return SizedBox();
      },
    );
  }
}
