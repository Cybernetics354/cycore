import 'package:cycore/cycore.dart';
import 'package:flutter/material.dart';

class CachedImageExample extends StatefulWidget {
  const CachedImageExample({Key? key}) : super(key: key);

  @override
  _CachedImageExampleState createState() => _CachedImageExampleState();
}

class _CircularTest extends StatefulWidget {
  final double value;
  const _CircularTest({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  __CircularTestState createState() => __CircularTestState();
}

class __CircularTestState extends State<_CircularTest> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );

    animation = new Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
    animationController.addListener(() {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _CircularTest oldWidget) {
    animationController.animateTo(
      widget.value,
      curve: Curves.ease,
      duration: Duration(milliseconds: 400),
    );
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: animation.value,
    );
  }
}

class _CachedImageExampleState extends State<CachedImageExample> {
  bool widget1 = false;
  double val = 0.0;

  _increase() async {
    if (val >= 1.0) return _decrease();
    if (!mounted) return;

    setState(() {
      val += 0.1;
    });

    await Future.delayed(Duration(seconds: 1));
    _increase();
  }

  _decrease() async {
    if (val <= 0.0) return _increase();
    if (!mounted) return;

    setState(() {
      val -= 0.1;
    });

    await Future.delayed(Duration(seconds: 1));
    _decrease();
  }

  @override
  void initState() {
    super.initState();
    _increase();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      // "https://img.jakpost.net/c/2020/05/22/2020_05_22_95943_1590165618._large.jpg",
      "https://a.cdn-hotels.com/gdcs/production14/d7/285f425b-8354-4edf-bf70-712cf48f61da.jpg",
      // "https://lorem.ipsum",
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Cached Image"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            widget1 = !widget1;
          });
        },
      ),
      body: ListView(
        children: [
          ...List.generate(images.length, (index) {
            final _cindex = images[index];
            return Center(
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                width: 500.0,
                height: 500.0,
                child: CachedImage(
                  url: _cindex,
                  builder: (context, image) {
                    return Image(
                      image: image,
                      fit: BoxFit.cover,
                    );
                  },
                  configuration: CachedImageWidgetConfiguration(
                    evict: true,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class TestingLorem extends StatelessWidget {
  final bool widget1;
  const TestingLorem({Key? key, required this.widget1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 600),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: widget1
          ? Container(
              key: ValueKey("red"),
              color: Colors.red,
              width: 100.0,
              height: 100.0,
            )
          : Container(
              key: ValueKey("green"),
              width: 20.0,
              height: 60.0,
              color: Colors.green,
            ),
    );
  }
}
