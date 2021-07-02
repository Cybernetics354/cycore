part of cypage;

class CypageProvider extends InheritedWidget {
  CypageProvider({
    Key? key,
    required this.child,
    required this.controller,
  }) : super(key: key, child: child);

  final Widget child;
  final CypageController controller;

  static CypageProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CypageProvider>();
  }

  @override
  bool updateShouldNotify(CypageProvider oldWidget) {
    return true;
  }
}
