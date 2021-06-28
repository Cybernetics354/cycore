part of cypage;

class CypageDeployer extends InheritedWidget {
  CypageDeployer({
    Key? key,
    required this.child,
    required this.controller,
  }) : super(key: key, child: child);

  final Widget child;
  final CypageController controller;

  static CypageDeployer? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CypageDeployer>();
  }

  @override
  bool updateShouldNotify(CypageDeployer oldWidget) {
    return true;
  }
}
