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
