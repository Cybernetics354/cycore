import 'package:cycore/cycore.dart';
import 'package:flutter/material.dart';

class InfiniteScrollExample extends StatefulWidget {
  const InfiniteScrollExample({Key? key}) : super(key: key);

  @override
  _InfiniteScrollExampleState createState() => _InfiniteScrollExampleState();
}

class _InfiniteScrollExampleState extends State<InfiniteScrollExample> {
  final _Controller _controller = _Controller();

  @override
  void initState() {
    super.initState();
    _controller.initialize(_fetching);
  }

  Future<List<String>> _fetching(int offset) async {
    await Future.delayed(Duration(seconds: 1));
    if (offset > 50) throw "Error ler";
    return List.generate(15, (index) => (index + offset).toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Infinite Scroll"),
      ),
      body: InfiniteScroll<String>(
        controller: _controller,
        itemBuilder: (context, item, index) {
          return ListTile(
            title: Text("Index " + item),
          );
        },
      ),
    );
  }
}

class _Controller extends InfiniteScrollController<String> {}
