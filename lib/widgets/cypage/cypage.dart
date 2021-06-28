library cypage;

import 'dart:async';

import 'package:cycore/app/cycore_app.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

part 'cypage_controller.dart';
part 'cypage_models.dart';
part 'cypage_deployer.dart';

class Cypage<T> extends StatelessWidget {
  const Cypage({
    Key? key,
    required this.controller,
    required this.onActive,
    this.onError,
    this.onLoading,
    this.transitionBuilder,
    this.curve,
    this.duration,
  }) : super(key: key);

  final CypageController<T> controller;
  final Widget Function(BuildContext, CypageSnapshot<T>) onActive;
  final Widget Function(BuildContext, CypageSnapshot<T>)? onError;
  final Widget Function(BuildContext, CypageSnapshot<T>)? onLoading;
  final Widget Function(Widget, Animation<double>)? transitionBuilder;
  final Curve? curve;
  final Duration? duration;

  @override
  Widget build(BuildContext context) {
    final _settings = CycoreApp.of(context)?.cypageSettings;
    if (_settings == null) throw "There's no cycore app within widget tree";

    var _transition = transitionBuilder;
    _transition ??= _settings.transitionBuilder;

    var _curve = curve;
    _curve ??= _settings.curve;

    var _duration = duration;
    _duration ??= _settings.duration;

    return StreamBuilder<CypageSnapshot<T>>(
      stream: controller.mainStream ?? controller.stateStream,
      builder: (context, state) {
        return AnimatedSwitcher(
          layoutBuilder: (newWid, oldWid) => newWid!,
          transitionBuilder: _transition!,
          switchInCurve: _curve!,
          switchOutCurve: _curve,
          duration: _duration!,
          child: _build(context, state),
        );
      },
    );
  }

  Widget _build(
    BuildContext context,
    AsyncSnapshot<CypageSnapshot<T>> state,
  ) {
    final _settings = CycoreApp.of(context)?.cypageSettings;
    if (_settings == null) throw "There's no cycore app within widget tree";

    if (!state.hasData) {
      return SizedBox();
    }

    final _data = state.data;

    /// Throw error if data is null
    if (_data == null) throw "Data can't be null";

    switch (_data.state) {
      case _CypageState.active:
        return Container(
          key: ValueKey("active"),
          child: onActive(context, _data),
        );

      case _CypageState.loading:
        {
          if (onLoading == null) return _settings.onLoading(context, _data);
          return Container(
            key: ValueKey("loading"),
            child: onLoading!(context, _data),
          );
        }

      case _CypageState.error:
        {
          if (onError == null) return _settings.onError(context, _data);
          return Container(
            key: ValueKey("error"),
            child: onError!(context, _data),
          );
        }

      default:
        throw "Unidentified state";
    }
  }
}
