library home;

import 'package:cycore/cycore.dart';
import 'package:example/main.dart';
import 'package:flutter/material.dart';

part '_controller.dart';
part '_controller2.dart';
part '_controller3.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _Controller _controller = _Controller();
  final _Controller _controllerSecond = _Controller();
  final _Controller2 _controller2 = _Controller2();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    print("Initstate occured");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            useRootNavigator: false,
            context: context,
            routeSettings: RouteSettings(
              name: "/dialogs",
            ),
            builder: (firstContext) {
              return AlertDialog(
                title: Text(firstContext.hashCode.toString()),
                content: Text(context.hashCode.toString()),
                actions: [
                  TextButton(
                    child: Text("Pop"),
                    onPressed: () {
                      showDialog(
                        useRootNavigator: false,
                        context: firstContext,
                        builder: (secondContext) {
                          return AlertDialog(
                            title: Text(secondContext.hashCode.toString()),
                            content: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(firstContext.hashCode.toString()),
                                  Text(context.hashCode.toString()),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: Text("Lorem"),
                                onPressed: () {
                                  Navigator.pop(firstContext);
                                },
                              )
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
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
        controller: _controllerSecond,
        child: CypageDeployer(
          controller: _controller2,
          child: CypageDeployer(
            controller: _controller,
            child: Cypage<String>(
              controller: _controller,
              onActive: (context, snapshot) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        snapshot.data ?? "Lorem",
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
