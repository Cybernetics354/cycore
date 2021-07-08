library infinite_scroll;

import 'dart:async';

import 'package:cycore/cycore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

part 'infinite_scroll_controller.dart';

class InfiniteScroll<T> extends StatelessWidget with CyMaterialGuideMixin {
  InfiniteScroll({
    Key? key,
    required this.controller,
    required this.itemBuilder,
    this.onItemEmpty,
  }) : super(key: key);

  final InfiniteScrollController<T> controller;
  final Widget Function(BuildContext, T, int) itemBuilder;
  final Widget Function(BuildContext)? onItemEmpty;

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
                Container(
                  width: context.screenWidth,
                  padding: padSym(ver: 30.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              ],
              if (_data.isErrorOccured) ...[
                Container(
                  width: context.screenWidth,
                  padding: padSym(
                    ver: 30.0,
                    hor: 30.0,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Terjadi error"),
                        TextButton(
                          child: Text("Coba Lagi"),
                          onPressed: () {
                            controller.fetchLast();
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ],
          );
        },
      ),
    );
  }
}
