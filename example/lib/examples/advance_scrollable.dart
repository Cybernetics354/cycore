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
