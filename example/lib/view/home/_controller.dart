part of home;

class _Controller extends CypageController<String> {
  changeToActive() async {
    loading();
    await Future.delayed(Duration(seconds: 3));

    active("Testing");
  }

  changeToError() async {
    loading();
    await Future.delayed(Duration(seconds: 3));

    error(NetworkError("Error Bro"));
  }

  @override
  Stream<CypageSnapshot<String>>? get mainStream => stateStream;

  @override
  void handleEvent(CypageEvent event) {
    if (event is ReloadEvent) {
      changeToActive();
    }
  }
}
