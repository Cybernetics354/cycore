---
title: AdvanceScrollable
---

`AdvanceScrollable` Create advance scrollable with controller that can animateTo specific index, best use for scrollable with less item.

## Usage

```dart
import 'package:cycore/cycore.dart';
import 'package:flutter/material.dart';

class AdvanceScrollableTesting extends StatefulWidget {
  const AdvanceScrollableTesting({Key? key}) : super(key: key);

  @override
  _AdvanceScrollableTestingState createState() => _AdvanceScrollableTestingState();
}

class _AdvanceScrollableTestingState extends State<AdvanceScrollableTesting> {
  final AdvanceScrollableController _controller = AdvanceScrollableController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _controller.animateToIndex(10);
        },
      ),
      body: Center(
        child: AdvanceScrollable(
          controller: _controller,
          children: List.generate(10, (index) {
            return ListTile(
              title: Text("This is $index"),
            );
          }),
        ),
      ),
    );
  }
}
```

## Constructors
**AdvanceScrollable**();<br />
Construct AdvanceScrollable

## Properties

**controller** -> `AdvanceScrollableController`<br />
Controller for Advance Scrollable.<br />
*non-nullable*

**children** -> `List<Widget>`<br />
Children for Advance Scrollable.<br />
*non-nullable*

**scrollDirection** -> `Axis`<br />
Scroll direction, there's `Axis.horizontal` and `Axis.vertical`.<br />
*nullable*

**clipBehavior** -> `Clip`<br />
Default to `Clip.hardEdge`.<br />
*nullable*

**dragStartBehavior** -> `DragStartBehavior`<br />
Default to `DragStartBehavior.start`.<br />
*nullable*

**keyboardDismissBehavior** -> `ScrollViewKeyboardDismissBehavior`<br />
Default to `ScrollViewKeyboardDismissBehavior.manual`.<br />
*nullable*

**padding** -> `EdgeInsetsGeometry`<br />
Padding for view.<br />
*non-nullable*

**physics** -> `ScrollPhysics`<br />
Scrollable Physics.<br />
*nullable*

**restorationId** -> `String`<br />
-.<br />
*nullable*

**reverse** -> bool<br />
Default to true.<br />
*nullable*

<br />

#### Maintained By corecybernetics354@gmail.com