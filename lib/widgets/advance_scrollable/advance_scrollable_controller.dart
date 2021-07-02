part of scrollable_index_list;

/// Controller for [AdvanceScrollable] widget
class AdvanceScrollableController {
  Map<int, BuildContext> _contexes = {};
  ScrollController scrollController;

  AdvanceScrollableController({
    ScrollController? controller,
  }) : scrollController = controller ?? ScrollController();

  _clear() {
    _contexes = {};
  }

  _addContext(int index, BuildContext context) {
    _contexes[index] = context;
  }

  /// Animate to given index, throw an exception if the given index
  /// isn't exist or not rendered yet
  Future animateToIndex(
    int index, {
    Duration? duration,
    double? alignment,
    Curve? curve,
    ScrollPositionAlignmentPolicy? alignmentPolicy,
  }) async {
    // TODO :: Adding global configuration
    duration ??= Duration(seconds: 1);
    alignment ??= 0.0;
    curve ??= Curves.ease;
    alignmentPolicy ??= ScrollPositionAlignmentPolicy.explicit;

    final _context = _contexes[index];
    await Scrollable.ensureVisible(
      _context!,
      duration: duration,
      alignment: alignment,
      curve: curve,
      alignmentPolicy: alignmentPolicy,
    );
  }

  BuildContext? childContext(int index) {
    return _contexes[index];
  }

  void dispose() {
    scrollController.dispose();
  }
}
