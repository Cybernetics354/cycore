library cached_image;

import 'dart:async';
import 'dart:ui' as ui;

import 'package:cycore/app/cycore_app.dart';
import 'package:cycore/utils/platform/platfom.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:rxdart/rxdart.dart';

part 'image_loader/_interface.dart';
part 'image_loader/_mobile.dart';
part 'image_loader/_web.dart';
part 'image_loader/image_loader.dart';
part 'image_provider/image_provider.dart';
part 'image_completer/image_completer.dart';
part 'cached_image_controller.dart';
part 'models/cached_image_states.dart';
part 'models/_decoding_model.dart';
part 'models/_widget_configuration.dart';
part 'models/state_snapshot.dart';
part 'models/typedefs.dart';
part 'widgets/cached_image_helper.dart';
part 'widgets/cached_image_deployer.dart';

class CachedImage extends StatefulWidget {
  final String url;
  final Widget Function(BuildContext, ImageProvider) builder;
  final CachedImageWidgetConfiguration? configuration;
  final CachedImageController? controller;
  final Duration? transitionDuration;
  final Duration? reverseTransitionDuration;
  final Widget Function(Widget, Animation<double>)? transitionBuilder;
  final Widget Function(Widget?, List<Widget>)? layoutBuilder;
  final Curve? switchInCurve;
  final Curve? switchOutCurve;
  final Widget Function(BuildContext)? onLoading;
  final Widget Function(BuildContext, FetchingCachedImageState)? onDownload;
  final Widget Function(BuildContext, ErrorCachedImageState)? onError;
  final bool? evict;
  const CachedImage({
    Key? key,
    required this.url,
    required this.builder,
    this.configuration,
    this.controller,
    this.layoutBuilder,
    this.onDownload,
    this.onError,
    this.onLoading,
    this.reverseTransitionDuration,
    this.switchInCurve,
    this.switchOutCurve,
    this.transitionBuilder,
    this.transitionDuration,
    this.evict,
  }) : super(key: key);

  @override
  _CachedImageState createState() => _CachedImageState();
}

class _CachedImageState extends State<CachedImage> {
  late CachedImageController controller;
  bool controllerSetup = false;
  late String resolvedUrl;

  _setupController() {
    final _w = widget;
    controller = _w.controller == null ? CachedImageController() : _w.controller!;
    controller._iddleState();
  }

  @override
  void initState() {
    super.initState();
    _setupController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = CycoreApp.of(context)!.cachedImageSettings;

    final _w = widget;

    return CachedImageDeployer(
      controller: controller,
      child: StreamBuilder<CachedImageStateSnapshot?>(
        stream: controller.stateStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return SizedBox();

          final _data = snapshot.data!;

          // Do initial setup when the image state is iddle
          if (_data.currentState is IddleCachedImageState)
            controller._initialSetup(
              context,
              settings,
              widget.url,
              shouldEvict: widget.evict,
            );

          if (_data.resolvedUrl == null) return SizedBox();

          return CachedImageHelper(
            key: ValueKey(_data.resolvedUrl),
            snapshot: _data,
            url: _w.url,
            builder: _w.builder,
            layoutBuilder: _w.layoutBuilder,
            onDownload: _w.onDownload,
            onError: _w.onError,
            onLoading: _w.onLoading,
            reverseTransitionDuration: _w.reverseTransitionDuration,
            switchInCurve: _w.switchInCurve,
            switchOutCurve: _w.switchOutCurve,
            transitionBuilder: _w.transitionBuilder,
            transitionDuration: _w.transitionDuration,
            image: CachedImageProvider(
              _data.resolvedUrl!,
              controller: controller,
            ),
          );
        },
      ),
    );
  }
}
