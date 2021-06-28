library home;

import 'package:cycore/cycore.dart';
import 'package:example/events.dart';
import 'package:flutter/material.dart';

part '_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _Controller _controller = _Controller();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lorem"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _controller.changeToActive();
            },
          ),
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              _controller.changeToError();
            },
          ),
        ],
      ),
      body: CypageDeployer(
        controller: _controller,
        child: Cypage<String>(
          controller: _controller,
          onActive: (context, snapshot) {
            return Center(
              child: Text(
                snapshot.data ?? "Lorem",
              ),
            );
          },
        ),
      ),
    );
  }
}
