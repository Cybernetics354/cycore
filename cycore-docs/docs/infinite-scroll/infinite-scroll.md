---
title: InfinteScroll
---

`InfinteScroll` Creating an infinite scroll widget, useful when you need to create a list that lazily fetch items from backend when scrolled on the edge

![Infinite Scroll](/img/examples/infinite-scroll.gif)

## Usage

```dart

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
```

## Constructors
**InfinteScroll**();<br />
Construct InfinteScroll

## Properties

**controller** -> `InfiniteScrollController<T>`<br />
Infinite Scroll Controller.<br />
*required, non-nullable*

**itemBuilder** -> `Widget Function(BuildContext, T, int)`<br />
Item builder for list.<br />
*required, non-nullable*

**onItemEmpty** -> `Widget Function(BuildContext)`<br />
Builder when there's no item inside the list.<br />
*nullable*

**onError** -> `Widget Function(BuildContext, CypageError)`<br />
Builder on the bottom of the list when error occured when fetching data from end point.<br />
*nullable*

**onLoading** -> `Widget Function(BuildContext)`<br />
Builder on the bottom of the list when controller refetching data.<br />
*nullable*


<br />

#### Maintained By corecybernetics354@gmail.com