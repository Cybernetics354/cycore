---
title: Cypage
---

`Cypage` a widget for base page, it's providing page state manager with RxDart, useful for every top page use. 

## Usage

you need to create `CypageController` first.

```dart title=controller.dart
class _Controller extends CypageController<String> {
  changeToActive() async {
    loading();
    await Future.delayed(Duration(seconds: 3));

    active("Testing");
  }

  changeToError() async {
    loading();
    await Future.delayed(Duration(seconds: 3));

    error("Error Bro");
  }

  @override
  Stream<CypageSnapshot<String>>? get mainStream => stateStream;

  @override
  void handleEvent(CypageEvent event) {
    if (event is CyReload) {
      changeToActive();
    }
  }
}
```

Then use the controller on view.

```dart title=home.dart
class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _Controller _controller = _Controller();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lorem"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _controller.changeToActive();
            },
          ),
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              _controller.changeToError();
            },
          ),
        ],
      ),
      body: CypageDeployer(
        controller: _controller,
        child: Cypage<String>(
          controller: _controller,
          onActive: (context, snapshot) {
            return Center(
              child: Text(
                snapshot.data ?? "Lorem",
              ),
            );
          },
        ),
      ),
    );
  }
}
```

To avoid memory leaks, don't forget dispose the controller.

## Constructors
**Cypage**();<br />
Construct Cypage

## Properties

**controller** -> `CypageController`<br />
CypageController, Bussiness state running here.<br />
*required*

**onActive** -> `Widget Function(BuildContext, CypageSnapshot<T>)`<br />
Active page view.<br />
*required*

**onError** -> `Widget Function(BuildContext, CypageSnapshot<T>)`<br />
Error page view, by default it will use the global setting.<br />
*optional*

**onLoading** -> `Widget Function(BuildContext, CypageSnapshot<T>)`<br />
Loading page view, by default it will use the global setting.<br />
*optional*

**transitionBuilder** -> `Widget Function(Widget, Animation<double>)`<br />
Transition between states.<br />
*optional*

**curve** -> `Curve`<br />
Transition curve, by default it will use the global setting.<br />
*optional*

**duration** -> `Duration`<br />
Transition duration, by default it will use the global setting `Duration(milliseconds: 400)`.<br />
*optional*

<br />

#### Maintained By ex: corecybernetics354@gmail.com