part of cached_image;

class CachedImageDeployer extends InheritedWidget {
  CachedImageDeployer({
    Key? key,
    required this.child,
    required this.controller,
  }) : super(key: key, child: child);

  final Widget child;
  final CachedImageController controller;

  static CachedImageDeployer? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CachedImageDeployer>();
  }

  @override
  bool updateShouldNotify(CachedImageDeployer oldWidget) {
    return true;
  }
}
