---
title: CypageError
---

`CypageError` abstract class for `Cypage` error state

## Source Code

```dart
abstract class CypageError {
  dynamic error;

  CypageError(this.error);
}

class NetworkError extends CypageError {
  NetworkError(error) : super(error);
}
```

You can create custom `CypageError` by extending it.

## Constructors
**CypageError**(dynamic error);<br />
Construct CypageError

## Properties

No Properties.

<br />

#### Maintained By ex: corecybernetics354@gmail.com