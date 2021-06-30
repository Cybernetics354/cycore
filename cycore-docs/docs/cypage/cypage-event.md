---
title: CypageEvent
---

`CypageEvent` abstract class for sending event to controller.

## Source Code

```dart
abstract class CypageEvent {}

/// Use this event to send reload event to controllers
class CypageReload<T> extends CypageEvent {
  T? data;

  CypageReload({
    this.data,
  });
}

/// Use this event to send fetch event to controllers
class CypageFetch<T> extends CypageEvent {
  T? data;

  CypageFetch({
    this.data,
  });
}
```

You can create custom `CypageEvent` by extending it.

## Constructors
**CypageEvent**();<br />
Construct CypageEvent

## Properties

No Properties.

<br />

#### Maintained By corecybernetics354@gmail.com