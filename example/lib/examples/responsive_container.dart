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
