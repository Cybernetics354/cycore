library home;

import 'package:cycore/cycore.dart';
import 'package:example/main.dart';
import 'package:example/view/scrollable_index_list/scrollable_index_list.dart';
import 'package:flutter/material.dart';

part '_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _Controller _controller = _Controller();
  final ScrollableIndexListController _scrollController = ScrollableIndexListController();

  int items = 5;

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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          _scrollController.animateTo(0);
        },
      ),
      body: Cypage<String>(
        controller: _controller,
        onActive: (context, snapshot) {
          return Center(
            child: ScrollableIndexList(
              controller: _scrollController,
              children: List.generate(items, (index) {
                Color color = Colors.red;

                switch (index) {
                  case 1:
                    {
                      color = Colors.green;
                      break;
                    }

                  case 2:
                    {
                      color = Colors.yellow;
                      break;
                    }

                  case 3:
                    {
                      color = Colors.blue;
                      break;
                    }

                  case 4:
                    {
                      color = Colors.purple;
                      break;
                    }

                  default:
                }

                return Container(
                  width: context.screenWidth,
                  height: 300.0,
                  color: color,
                  child: Center(
                    child: Text(index.toString()),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
