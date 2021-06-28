import 'package:cycore/cycore.dart';
import 'package:example/view/home/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CycoreApp(
      child: MaterialApp(
        home: HomeView(),
      ),
    );
  }
}
