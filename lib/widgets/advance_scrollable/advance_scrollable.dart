library scrollable_index_list;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

part 'advance_scrollable_controller.dart';

/// Create advance scrollable with controller that can animateTo
/// specific index, best use for scrollable with less item.
class AdvanceScrollable extends StatelessWidget {
  const AdvanceScrollable({
    Key? key,
    required this.children,
    required this.controller,
    this.scrollDirection = Axis.vertical,
    this.clipBehavior = Clip.hardEdge,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.padding,
    this.physics,
    this.restorationId,
    this.reverse = false,
  }) : super(key: key);

  /// Children of the widget
  final List<Widget> children;

  final AdvanceScrollableController controller;

  /// The axis along which the scroll view scrolls.
  ///
  /// Defaults to [Axis.vertical].
  final Axis scrollDirection;

  /// Whether the scroll view scrolls in the reading direction.
  ///
  /// For example, if the reading direction is left-to-right and
  /// [scrollDirection] is [Axis.horizontal], then the scroll view scrolls from
  /// left to right when [reverse] is false and from right to left when
  /// [reverse] is true.
  ///
  /// Similarly, if [scrollDirection] is [Axis.vertical], then the scroll view
  /// scrolls from top to bottom when [reverse] is false and from bottom to top
  /// when [reverse] is true.
  ///
  /// Defaults to false.
  final bool reverse;

  /// The amount of space by which to inset the child.
  final EdgeInsetsGeometry? padding;

  /// How the scroll view should respond to user input.
  ///
  /// For example, determines how the scroll view continues to animate after the
  /// user stops dragging the scroll view.
  ///
  /// Defaults to matching platform conventions.
  final ScrollPhysics? physics;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip clipBehavior;

  /// {@macro flutter.widgets.scrollable.restorationId}
  final String? restorationId;

  /// {@macro flutter.widgets.scroll_view.keyboardDismissBehavior}
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  @override
  Widget build(BuildContext context) {
    controller._clear();

    List<Widget> _children = List.generate(children.length, (index) {
      final _cindex = children[index];
      return _RegisterContext(
        key: _cindex.key,
        child: _cindex,
        index: index,
      );
    });

    Widget _child = SizedBox();
    switch (scrollDirection) {
      case Axis.horizontal:
        {
          _child = _buildRow(children: _children);
          break;
        }

      case Axis.horizontal:
        {
          _child = _buildColumn(children: _children);
          break;
        }

      default:
    }

    return _AdvanceScrollableProvider(
      controller: controller,
      child: SingleChildScrollView(
        scrollDirection: scrollDirection,
        clipBehavior: clipBehavior,
        controller: controller.scrollController,
        dragStartBehavior: dragStartBehavior,
        keyboardDismissBehavior: keyboardDismissBehavior,
        padding: padding,
        physics: physics,
        restorationId: restorationId,
        reverse: reverse,
        child: _child,
      ),
    );
  }

  /// Build when the scrollDirection is [Axis.horizontal]
  Widget _buildRow({required List<Widget> children}) {
    return Row(
      children: children,
    );
  }

  /// Build when the scrollDirection is [Axis.vertical]
  Widget _buildColumn({required List<Widget> children}) {
    return Column(
      children: children,
    );
  }
}

/// Registering current context to controller in [_AdvanceScrollableProvider]
class _RegisterContext extends StatelessWidget {
  const _RegisterContext({
    Key? key,
    required this.child,
    required this.index,
  }) : super(key: key);

  final Widget child;
  final int index;

  @override
  Widget build(BuildContext context) {
    final _provider = _AdvanceScrollableProvider.of(context);

    if (_provider == null) throw "There's no _AdvanceScrollableProvider in the widget tree";
    _provider.controller._addContext(index, context);

    return Container(
      key: key,
      child: child,
    );
  }
}

/// Using provider to grant child access to [_RegisterContext] accessing and
/// registering the current context every build.
class _AdvanceScrollableProvider extends InheritedWidget {
  _AdvanceScrollableProvider({
    Key? key,
    required this.child,
    required this.controller,
  }) : super(key: key, child: child);

  final Widget child;
  final AdvanceScrollableController controller;

  static _AdvanceScrollableProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_AdvanceScrollableProvider>();
  }

  @override
  bool updateShouldNotify(_AdvanceScrollableProvider oldWidget) {
    return true;
  }
}
