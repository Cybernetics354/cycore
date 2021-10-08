part of cycore_app;

/// Settings for [CachedImage] widget
abstract class CachedImageSettings {
  /// Widget default configuration
  late CachedImageWidgetConfiguration widgetConf;

  /// Url resolve, return the new valid url
  Future<String> urlResolve(BuildContext context, String url);

  /// Widget builder by default, if the widget has it's own
  /// builder, it will not inherit this builder
  Widget builder(
    BuildContext context,
    CachedImageStateSnapshot snapshot,
    ImageProvider image,
    String url,
  );

  /// Widget builder on loading state by default, on loading insist
  /// when the initial call
  Widget onLoading(BuildContext context, String url);

  /// Widget builder on downloading state by default, on downloading insist
  /// when download the image
  Widget onDownloading(BuildContext context, FetchingCachedImageState state, String url);

  /// Widget builder on error state by default
  Widget onError(BuildContext context, ErrorCachedImageState state, String url);

  CachedImageSettings({required this.widgetConf});
}

class CachedImageSettingsDefault extends CachedImageSettings {
  CachedImageSettingsDefault() : super(widgetConf: CachedImageSettingsDefault.defaultWidgetConf);

  @override
  Widget builder(
    BuildContext context,
    CachedImageStateSnapshot snapshot,
    ImageProvider image,
    String url,
  ) {
    return CachedImageHelper(
      image: image,
      snapshot: snapshot,
      url: url,
    );
  }

  @override
  Widget onDownloading(BuildContext context, FetchingCachedImageState state, String url) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget onError(
    BuildContext context,
    ErrorCachedImageState state,
    String url,
  ) {
    return Center(
      child: IconButton(
        icon: Icon(Icons.error),
        onPressed: () {
          final _controller = CachedImageDeployer.of(context)!.controller;
          _controller.reload();
        },
      ),
    );
  }

  @override
  Widget onLoading(BuildContext context, String url) {
    return CircularProgressIndicator();
  }

  @override
  Future<String> urlResolve(BuildContext context, String url) async {
    return url;
  }

  static CachedImageWidgetConfiguration defaultWidgetConf = CachedImageWidgetConfiguration(
    alignment: Alignment.center,
    evict: false,
    fit: BoxFit.cover,
    imageRepeat: ImageRepeat.noRepeat,
  );
}
