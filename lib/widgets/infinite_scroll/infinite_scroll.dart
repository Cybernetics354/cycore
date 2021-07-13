library infinite_scroll;

import 'dart:async';

import 'package:cycore/cycore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

part 'infinite_scroll_controller.dart';
part 'infinite_scroll_models.dart';

/// Infinite scroll widget that support pull to refresh and refetching
/// when the scroll is on edge
class InfiniteScroll<T> extends StatelessWidget with CyMaterialGuideMixin {
  InfiniteScroll({
    Key? key,
    required this.controller,
    required this.itemBuilder,
    this.onItemEmpty,
    this.onError,
    this.onLoading,
  }) : super(key: key);

  /// `InfiniteScrollController<T>` controller for infinite scroll
  final InfiniteScrollController<T> controller;

  /// Item build, T for item
  final Widget Function(BuildContext, T, int) itemBuilder;

  /// Build on item empty builder
  final Widget Function(BuildContext)? onItemEmpty;

  /// Build loading widget on bottom when refetching
  final Widget Function(BuildContext)? onLoading;

  /// Build error widget on bottom when there's error occured when refetching
  final Widget Function(BuildContext, CypageError?)? onError;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.reset();
      },
      child: Cypage<InfiniteScrollSnapshot<List<T>>>(
        controller: controller,
        onActive: (context, state) {
          if (state.data == null) throw "State cannot be null";
          final _app = CycoreApp.of(context);

          if (_app == null) throw "There's no CycoreApp within widget tree";
          final _settings = _app.infiniteScrollSettings;

          final _data = state.data;
          if (_data == null) throw "There's no data inside snapshot";

          final _state = _data.data;

          if (_state.isEmpty) {
            if (onItemEmpty == null) return _settings.onEmptyBuilder(context);
            return onItemEmpty!(context);
          }

          return ListView(
            physics: AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            controller: controller.scrollController,
            children: [
              ...List.generate(_state.length, (index) {
                final _cindex = _state[index];
                return itemBuilder(context, _cindex, index);
              }),
              if (_data.isFetching) ...[
                onLoading == null ? _settings.loadingBuilder(context) : onLoading!(context),
              ],
              if (_data.isErrorOccured) ...[
                onError == null
                    ? _settings.onErrorBuilder(
                        context,
                        _data.error,
                      )
                    : onError!(
                        context,
                        _data.error,
                      ),
              ],
            ],
          );
        },
      ),
    );
  }
}
