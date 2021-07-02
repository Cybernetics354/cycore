import 'package:cycore/cycore.dart';
import 'package:example/view/home/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class ReloadEvent extends CypageEvent {}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CycoreApp(
      cypageSettings: CypageSettings(
        onError: (context, snapshot) {
          final _deployer = CypageDeployer.of(context);
          if (_deployer == null)
            return Center(
              child: Text("Error"),
            );

          final _controller = _deployer.controller;
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Error"),
                TextButton(
                  child: Text("Reload"),
                  onPressed: () {
                    _controller.addEvent(ReloadEvent());
                  },
                )
              ],
            ),
          );
        },
      ),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.green,
          accentColor: Colors.green,
        ),
        home: HomeView(),
      ),
    );
  }
}
