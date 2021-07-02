import 'package:flutter/material.dart';
import 'package:cycore/cycore.dart';

class TestingBottomSheet extends BottomSheetEvent {
  String title;
  String desc;

  TestingBottomSheet({
    required this.title,
    required this.desc,
  });

  @override
  Future build(BuildContext context) async {
    final _text = context.textTheme;
    return await showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: _text.headline4,
              ),
              Text(
                desc,
                style: _text.bodyText1,
              ),
              TextButton(
                child: Text("Tap Me"),
                onPressed: () {
                  context.pop(true);
                },
              )
            ],
          ),
        );
      },
    );
  }
}
