import 'package:cycore/cycore.dart';
import 'package:flutter/material.dart';

class AdvanceScrollableTesting extends StatefulWidget {
  const AdvanceScrollableTesting({
    Key? key,
    this.count = 10,
    this.onTap = 5,
  }) : super(key: key);

  final int count;
  final int onTap;

  @override
  _AdvanceScrollableTestingState createState() => _AdvanceScrollableTestingState();
}

class _AdvanceScrollableTestingState extends State<AdvanceScrollableTesting> {
  final AdvanceScrollableController _controller = AdvanceScrollableController();

  bool _isHoriz = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _axis = Axis.vertical;

    if (_isHoriz) {
      _axis = Axis.horizontal;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Advance Scrollable"),
        actions: [
          IconButton(
            icon: Icon(Icons.switch_camera_outlined),
            onPressed: () {
              setState(() {
                _isHoriz = !_isHoriz;
              });
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Text(
          "5",
          style: context.textTheme.headline4?.copyWith(
            color: Colors.white,
          ),
        ),
        onPressed: () {
          _controller.animateToIndex(widget.onTap);
        },
      ),
      body: AdvanceScrollable(
        scrollDirection: _axis,
        controller: _controller,
        children: List.generate(widget.count, (index) {
          return Container(
            width: context.screenWidth,
            height: 500.0,
            color: Colors.green.withRed(index * 25),
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
