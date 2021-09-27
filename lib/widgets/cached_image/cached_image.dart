library cached_image;

import 'dart:async';
import 'dart:ui' as ui;

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

class CachedImage extends StatefulWidget {
  final String url;
  final bool evict;
  final AlignmentGeometry? alignment;
  final Rect? centerSlice;
  final Color? color;
  final BlendMode? blendMode;
  final bool? excludeFromSemantics;
  final FilterQuality? filterQuality;
  final BoxFit? fit;
  final ImageFrameBuilder? frameBuilder;
  final double? height;
  final double? width;
  final bool? isAntiAlias;
  final bool? isGaplessPlayback;
  final bool? matchTextDirection;
  final ImageRepeat? imageRepeat;
  final String? semanticLabel;
  final CachedImageController? controller;
  final bool useWidgetAsMain;
  const CachedImage({
    Key? key,
    required this.url,
    this.evict = false,
    this.alignment,
    this.blendMode,
    this.centerSlice,
    this.color,
    this.excludeFromSemantics,
    this.filterQuality,
    this.fit,
    this.frameBuilder,
    this.height,
    this.imageRepeat,
    this.isAntiAlias,
    this.isGaplessPlayback,
    this.matchTextDirection,
    this.semanticLabel,
    this.width,
    this.controller,
    this.useWidgetAsMain = true,
  }) : super(key: key);

  @override
  _CachedImageState createState() => _CachedImageState();
}

class _CachedImageState extends State<CachedImage> {
  late CachedImageController controller;

  _setupController() {
    final _w = widget;

    controller = CachedImageController();
    if (_w.controller != null) controller = _w.controller!;

    controller.setWidget(
      alignment: _w.alignment,
      blendMode: _w.blendMode,
      centerSlice: _w.centerSlice,
      color: _w.color,
      evict: _w.evict,
      excludeFromSemantics: _w.excludeFromSemantics,
      filterQuality: _w.filterQuality,
      fit: _w.fit,
      frameBuilder: _w.frameBuilder,
      height: _w.height,
      imageRepeat: _w.imageRepeat,
      isAntiAlias: _w.isAntiAlias,
      isGaplessPlayback: _w.isGaplessPlayback,
      matchTextDirection: _w.matchTextDirection,
      semanticLabel: _w.semanticLabel,
      url: _w.url,
      width: _w.width,
    );
  }

  T? _compare<T>(T? a, T? b) {
    if (a == null || a == b) return null;
    return a;
  }

  _changeDependency(CachedImage oldWidget) {
    final _w = widget;
    controller.setWidget(
      alignment: _compare(_w.alignment, oldWidget.alignment),
      blendMode: _compare(_w.blendMode, oldWidget.blendMode),
      centerSlice: _compare(_w.centerSlice, oldWidget.centerSlice),
      color: _compare(_w.color, oldWidget.color),
      evict: _compare(_w.evict, oldWidget.evict),
      excludeFromSemantics: _compare(_w.excludeFromSemantics, oldWidget.excludeFromSemantics),
      filterQuality: _compare(_w.filterQuality, oldWidget.filterQuality),
      fit: _compare(_w.fit, oldWidget.fit),
      frameBuilder: _compare(_w.frameBuilder, oldWidget.frameBuilder),
      height: _compare(_w.height, oldWidget.height),
      imageRepeat: _compare(_w.imageRepeat, oldWidget.imageRepeat),
      isAntiAlias: _compare(_w.isAntiAlias, oldWidget.isAntiAlias),
      isGaplessPlayback: _compare(_w.isGaplessPlayback, oldWidget.isGaplessPlayback),
      matchTextDirection: _compare(_w.matchTextDirection, oldWidget.matchTextDirection),
      semanticLabel: _compare(_w.semanticLabel, oldWidget.semanticLabel),
      url: _compare(_w.url, oldWidget.url),
      width: _compare(_w.width, oldWidget.width),
    );
  }

  @override
  void didUpdateWidget(covariant CachedImage oldWidget) {
    if (widget.useWidgetAsMain) _setupController();
    if (!widget.useWidgetAsMain) _changeDependency(oldWidget);
    super.didUpdateWidget(oldWidget);
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
    return StreamBuilder<CachedImageStateSnapshot?>(
      stream: controller.stateStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data?.widgetConf == null) {
          return Center(child: CircularProgressIndicator());
        }

        final _data = snapshot.data;
        if (_data == null) throw "Data is null";

        final state = _data.currentState;
        final _w = _data.widgetConf!;

        return Stack(
          children: [
            if (state is InitiateCachedImageState || state is IddleCachedImageState) ...[
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
            if (state is FetchingCachedImageState) ...[
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Center(
                  child: CircularProgressIndicator(
                    value: state.progress,
                  ),
                ),
              )
            ],
            if (!(state is IddleCachedImageState)) ...[
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Image(
                  alignment: _w.alignment ?? Alignment.center,
                  centerSlice: _w.centerSlice,
                  color: _w.color,
                  colorBlendMode: _w.blendMode,
                  excludeFromSemantics: _w.excludeFromSemantics ?? false,
                  filterQuality: _w.filterQuality ?? FilterQuality.low,
                  fit: _w.fit,
                  frameBuilder: _w.frameBuilder,
                  height: _w.height,
                  width: _w.width,
                  isAntiAlias: _w.isAntiAlias ?? false,
                  gaplessPlayback: _w.isGaplessPlayback ?? false,
                  matchTextDirection: _w.matchTextDirection ?? false,
                  repeat: _w.imageRepeat ?? ImageRepeat.noRepeat,
                  semanticLabel: _w.semanticLabel,
                  image: CachedImageProvider(
                    _w.url,
                    controller: controller,
                  ),
                ),
              )
            ],
          ],
        );
      },
    );
  }
}
