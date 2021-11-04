library cypage;

import 'dart:async';

import 'package:cycore/app/cycore_app.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:animations/animations.dart';

part 'cypage_controller.dart';
part 'models/cypage_models.dart';
part 'widgets/cypage_deployer.dart';
part 'models/cypage_events.dart';
part 'models/cypage_loading_model.dart';
part 'models/cypage_error_model.dart';

class Cypage<T> extends StatelessWidget {
  const Cypage({
    Key? key,
    required this.controller,
    required this.onActive,
    this.onError,
    this.onLoading,
    this.transitionBuilder,
    this.curve,
    this.transitionType,
    this.duration,
    this.layoutBuilder,
    this.pageAnimationSwitcherBuilder,
  }) : super(key: key);

  final CypageController<T> controller;

  /// Transition Type
  final CypageTransitionType? transitionType;

  /// On page active, or when the controller calls `active()`
  final Widget Function(BuildContext, CypageSnapshot<T>) onActive;

  /// On page active, or when the controller calls `error()`, by default
  /// it will use the global configuration
  final Widget Function(BuildContext, CypageSnapshot<T>)? onError;

  /// On page active, or when the controller calls `loading()`, by default
  /// it will use the global configuration
  final Widget Function(BuildContext, CypageSnapshot<T>)? onLoading;

  /// Build transition between state, by default it will use the global
  /// configuration
  final Widget Function(Widget, Animation<double>)? transitionBuilder;

  /// Transition if using the [CypageTransitionType.pageTransitionSwitcher]
  final Widget Function(Widget, Animation<double>, Animation<double>)? pageAnimationSwitcherBuilder;

  /// Build transition layout between state
  final Widget Function(Widget?, List<Widget>)? layoutBuilder;

  /// Transition curve
  final Curve? curve;

  /// Transition duration
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

    var _layout = layoutBuilder;
    _layout ??= _settings.layoutBuilder;

    var _type = transitionType;
    _type ??= _settings.transitionType;

    var _transitionBuild = pageAnimationSwitcherBuilder;
    _transitionBuild ??= _settings.transitionBuilderIfSwitcher;

    return CypageProvider(
      controller: controller,
      child: StreamBuilder<CypageSnapshot<T>>(
        stream: controller.mainStream ?? controller.stateStream,
        builder: (context, state) {
          switch (_type) {
            case CypageTransitionType.animatedSwitcher:
              return AnimatedSwitcher(
                layoutBuilder: _layout!,
                transitionBuilder: _transition!,
                switchInCurve: _curve!,
                switchOutCurve: _curve,
                duration: _duration!,
                child: _build(context, state),
              );

            case CypageTransitionType.pageTransitionSwitcher:
              return PageTransitionSwitcher(
                transitionBuilder: _transitionBuild!,
                duration: _duration!,
                layoutBuilder: (childs) {
                  return _layout!(childs.first, childs);
                },
                child: _build(context, state),
              );

            default:
              throw UnimplementedError();
          }
        },
      ),
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
      case CypageState.active:
        return Container(
          // key: ValueKey(state.runtimeType),
          child: onActive(context, _data),
        );

      case CypageState.loading:
        {
          if (onLoading == null) return _settings.onLoading(context, _data);
          return Container(
            // key: ValueKey(state.runtimeType),
            child: onLoading!(context, _data),
          );
        }

      case CypageState.error:
        {
          if (onError == null) return _settings.onError(context, _data);
          return Container(
            // key: ValueKey(state.runtimeType),
            child: onError!(context, _data),
          );
        }

      default:
        throw "Unidentified state";
    }
  }
}
