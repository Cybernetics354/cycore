---
title: CypageSnapshot
---

`CypageSnapshot` state snapshot for Cypage

## Source Code

```dart
class CypageSnapshot<T> {
  T? data;
  CypageError? error;
  CypageLoading? loading;
  _CypageState state;

  CypageSnapshot({
    required this.state,
    this.data,
    this.error,
    this.loading,
  });

  bool get isLoading => state == _CypageState.loading;
  bool get isError => state == _CypageState.error;
  bool get isActive => state == _CypageState.active;
}
```

## Constructors
**CypageSnapshot**();<br />
Construct CypageSnapshot

## Properties

**data** -> `T`<br />
Active Data.<br />
*nullable*

**error** -> `CypageError`<br />
Error Data.<br />
*nullable*

**loading** -> `CypageLoading`<br />
Loading Data.<br />
*nullable*

**state** -> `_CypageState`<br />
Cypage State.<br />
*non-nullable*

**isLoading** -> `bool`<br />
Getter for loading.<br />
*non-nullable*

**isError** -> `bool`<br />
Getter for error.<br />
*non-nullable*

**isActive** -> `bool`<br />
Getter for active.<br />
*non-nullable*

**hasData** -> `bool`<br />
Getter for checking whether the snapshot has data or not.<br />
*non-nullable*


<br />

#### Maintained By corecybernetics354@gmail.com