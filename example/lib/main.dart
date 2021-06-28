import 'package:cycore/app/cycore_app.dart';
import 'package:cycore/cycore.dart';
import 'package:example/events.dart';
import 'package:example/view/home/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CycoreApp(
      cypageSettings: CypageSettings(
        onError: (context, state) {
          final _controller = CypageDeployer.of(context);
          final _isExist = _controller != null;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  state.error.toString(),
                  textAlign: TextAlign.center,
                ),
                if (_isExist) ...[
                  TextButton(
                    onPressed: () {
                      _controller!.controller.addEvent(CyReload());
                    },
                    child: Text("Ulangi"),
                  ),
                ],
              ],
            ),
          );
        },
      ),
      child: MaterialApp(
        home: HomeView(),
      ),
    );
  }
}
