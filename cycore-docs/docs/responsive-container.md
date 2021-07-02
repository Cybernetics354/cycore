---
title: ResponsiveContainer
sidebar_position: 4
---

`ResponsiveContainer` Building responsive container based on current viewport

![Responsive Container](/img/examples/responsive-container.gif)

## Usage

```dart
import 'package:cycore/cycore.dart';
import 'package:flutter/material.dart';

class ResponsiveContainerTesting extends StatelessWidget {
  const ResponsiveContainerTesting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = context.textTheme.headline3!.copyWith(
      color: Colors.white,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Responsive Container"),
      ),
      body: Center(
        child: ResponsiveContainer(
          builder: (context) {
            return Container(
              color: Colors.red,
              child: Center(
                child: Text(
                  "This is mobile",
                  style: style,
                ),
              ),
            );
          },
          tabletBuilder: (context) {
            return Container(
              color: Colors.green,
              child: Center(
                child: Text(
                  "This is Tablet",
                  style: style,
                ),
              ),
            );
          },
          desktopBuilder: (context) {
            return Container(
              color: Colors.yellow,
              child: Center(
                child: Text(
                  "This is Desktop",
                  style: style,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
```

## Constructors
**ResponsiveContainer**();<br />
Construct ResponsiveContainer

## Properties

**builder** -> `Widget Function(BuildContext)`<br />
Default builder, the builder apply to Smartphone, and if there's no builder upper, then apply this builder to all builders.<br />
*required, non-nullable*

**tabletBuilder** -> `Widget Function(BuildContext)`<br />
Tablet view builder.<br />
*nullable*

**desktopBuilder** -> `Widget Function(BuildContext)`<br />
Desktop view builder.<br />
*nullable*

<br />

#### Maintained By corecybernetics354@gmail.com