---
sidebar_position: 1
---

# Cycore

Cycore is a Flutter Superset, it's provide state management, animations, and the others
boilerplates, hopes that this package can make the project timeline faster.

## Getting Started

Currently Cycore is not stable yet, but if you want to get some try, you can fork or add
GitHub repo to your `pubspec.yaml`.

```yaml
dependencies:
  cycore:
    git: https://github.com/Cybernetics354/cycore.git
    ref: master
```

and then you can use it with import the package.

```dart
import 'package:cycore/cycore.dart';
```

**Take Note**, you need to specify the `CycoreApp` on top of Widget Tree, `CycoreApp` is
`InheritedWidget` that contains some Cycore Global Settings.


```dart
Widget build(BuildContext context) {
  return CycoreApp(
    child: MaterialApp(
      home: HomeView(),
    ),
  );
}
```
