---
title: CypageController
---

`CypageController` Controller for manage `Cypage` States.

## Source Code

```dart
abstract class CypageController<T> {
  T? lastData;
  CypageSnapshot<T>? lastState;

  /// Stream Controller for [state]
  final BehaviorSubject<CypageSnapshot<T>> stateController =
      new BehaviorSubject<CypageSnapshot<T>>();

  /// Stream pipe for [stateController]
  Stream<CypageSnapshot<T>> get stateStream => stateController.stream;

  Stream<CypageSnapshot<T>>? get mainStream;

  /// Stream sink for [stateController]
  StreamSink<CypageSnapshot<T>> get _stateIn => stateController.sink;

  /// Stream Controller for [event]
  final BehaviorSubject<CypageEvent> _eventController = new BehaviorSubject<CypageEvent>();

  /// Handle event, it's useful for mapping
  /// event from abstract class level
  @mustCallSuper
  void handleEvent(CypageEvent event);

  /// Function for change state to Active
  void active(T data) {
    lastData = data;

    // Assign if the value is null
    lastState ??= CypageSnapshot<T>(
      data: data,
      state: _CypageState.active,
    );

    lastState!.data = lastData!;
    lastState!.state = _CypageState.active;
    _insert(lastState!);
  }

  /// Function for change state to Loading
  void loading({dynamic data}) {
    lastState ??= CypageSnapshot<T>(
      state: _CypageState.loading,
    );

    lastState!.loading = data;
    lastState!.state = _CypageState.loading;
    _insert(lastState!);
  }

  /// Function for change state to Error
  void error(dynamic error) {
    lastState ??= CypageSnapshot<T>(
      state: _CypageState.error,
    );

    lastState!.error = error;
    lastState!.state = _CypageState.error;
    _insert(lastState!);
  }

  void addEvent(CypageEvent event) {
    if (_eventController.isClosed) return;
    _eventController.add(event);
  }

  void _insert(CypageSnapshot<T> event) {
    if (stateController.isClosed) return;
    _stateIn.add(event);
  }

  @mustCallSuper
  void dispose() {
    stateController.close();
    _eventController.close();
  }

  CypageController() {
    _eventController.listen(handleEvent);
    loading();
  }
}
```

## Constructors
**CypageController**();<br />
Construct CypageController

## Utility

**lastData** -> `T`<br />
Last active data.<br />
*nullable*

**lastState** -> `CypageSnapshot<T>`<br />
Controller's last state.<br />
*nullable*

**stateController** -> `BehaviorSubject<CypageSnapshot<T>>`<br />
Main state behavior subject.<br />
*non-null*

**stateStream** -> `Stream<CypageSnapshot<T>>`<br />
Default stream pipeline for `Cypage`.<br />
*non-null*

**mainStream** -> `Stream<CypageSnapshot<T>>`<br />
Stream that be used for `Cypage` Widget.<br />
*non-null*

**handleEvent** -> `Function(CypageEvent)`<br />
Callback for handle incoming event from abstract class.<br />
*mustCallSuper, non-nullable*

**active** -> `Function(T)`<br />
Function to change state to Active State.<br />
*-*

**loading** -> `Function({T})`<br />
Function to change state to Loading State.<br />
*-*

**error** -> `Function(T)`<br />
Function to change state to Error State.<br />
*-*

**addEvent** -> `Function(CypageEvent)`<br />
Function to insert event for eventListener.<br />
*-*

**dispose** -> `Function()`<br />
Function to disposing behavior objects inside class.<br />
*mustCallSuper*


<br />

#### Maintained By corecybernetics354@gmail.com