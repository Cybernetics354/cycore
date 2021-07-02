---
title: AdvanceScrollable
---

`AdvanceScrollable` Create advance scrollable with controller that can animateTo specific index, best use for scrollable with less item.

![Advance Scrollable](/img/examples/advance-scrollable.gif)

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
      appBar: AppBar(
        title: Text("Advance Scrollable"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _controller.animateToIndex(5);
        },
      ),
      body: AdvanceScrollable(
        controller: _controller,
        children: List.generate(10, (index) {
          return Container(
            width: context.screenWidth,
            height: 500.0,
            color: Colors.red.withGreen(index * 25),
            child: Center(
              child: Text(
                index.toString(),
                style: context.textTheme.headline3!.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          );
        }),
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