library home;

import 'package:example/events.dart';
import 'package:example/examples/advance_scrollable.dart';
import 'package:example/examples/infinite_scroll.dart';
import 'package:example/examples/responsive_container.dart';
import 'package:flutter/material.dart';
import 'package:cycore/cycore.dart';

part '_home_content.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<_Content> _contents = [
      _Content(
        page: AdvanceScrollableTesting(),
        title: "Advance Scrollable",
        url: "/advance-scrollable",
      ),
      _Content(
        title: "Responsive Container",
        page: ResponsiveContainerTesting(),
        url: "/responsive-container",
      ),
      _Content(
        title: "Infinite Scroll",
        page: InfiniteScrollExample(),
        url: "/infinite-scroll",
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Cycore"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          context.showBottomSheet(TestingBottomSheet(
            title: "Lorem",
            desc: "Lorem Ipsum dolor sit amet",
          ));
        },
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _contents.length,
          itemBuilder: (context, index) {
            final _items = _contents[index];

            return ListTile(
              title: Text(_items.title),
              onTap: () {
                context.push((context) => _items.page);
              },
            );
          },
        ),
      ),
    );
  }
}
