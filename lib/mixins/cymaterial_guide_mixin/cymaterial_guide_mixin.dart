library cy;

import 'package:flutter/material.dart';

mixin CyMaterialGuideMixin {
  /// Pixel Values
  final double d0 = 0.0;
  final double d1 = 1.0;
  final double d2 = 2.0;
  final double d3 = 3.0;
  final double d4 = 4.0;
  final double d5 = 5.0;
  final double d6 = 6.0;
  final double d8 = 8.0;
  final double d10 = 10.0;
  final double d12 = 12.0;
  final double d14 = 14.0;
  final double d16 = 16.0;
  final double d20 = 20.0;
  final double d24 = 24.0;
  final double d32 = 32.0;
  final double d40 = 40.0;
  final double d48 = 48.0;
  final double d56 = 56.0;
  final double d64 = 64.0;

  // Edge Insets Utils

  /// EdgeInsets.all([val])
  EdgeInsetsGeometry padAll(double val) => EdgeInsets.all(val);

  /// EdgeInsets.symmetric()
  EdgeInsetsGeometry padSym({
    double hor = 0.0,
    double ver = 0.0,
  }) =>
      EdgeInsets.symmetric(
        horizontal: hor,
        vertical: ver,
      );

  /// EdgeInsets.only()
  EdgeInsetsGeometry padOn({
    double t = 0.0,
    double b = 0.0,
    double l = 0.0,
    double r = 0.0,
  }) =>
      EdgeInsets.only(
        top: t,
        bottom: b,
        left: l,
        right: r,
      );

  // Border Radius Utils
  /// BorderRadius.all(Radius.circular([rad]))
  BorderRadiusGeometry radAll(double rad) => BorderRadius.all(Radius.circular(rad));

  /// BorderRadius.only()
  BorderRadiusGeometry radOnly({
    double tR = 0.0,
    double bL = 0.0,
    double tL = 0.0,
    double bR = 0.0,
  }) =>
      BorderRadius.only(
        bottomLeft: Radius.circular(bL),
        bottomRight: Radius.circular(bR),
        topRight: Radius.circular(tR),
        topLeft: Radius.circular(tL),
      );
}
