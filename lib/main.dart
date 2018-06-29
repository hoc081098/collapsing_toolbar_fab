import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final scrollController = new ScrollController();

  @override
  void initState() {
    scrollController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new CustomScrollView(
            controller: scrollController,
            slivers: <Widget>[
              new SliverAppBar(
                expandedHeight: 265.0,
                pinned: true,
                flexibleSpace: new FlexibleSpaceBar(
                  title: Text('Title'),
                  background:
                      new Image.asset('assets/bg.jpg', fit: BoxFit.cover),
                ),
              ),
              new SliverList(
                delegate: new SliverChildBuilderDelegate((context, index) {
                  return new Card(
                    elevation: 3.0,
                    child: new Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: new Text(
                        'Title ${index + 1}',
                        textScaleFactor: 1.4,
                      ),
                    ),
                  );
                }, childCount: 20),
              ),
            ],
          ),
          _buildFloatingActionButton(),
        ],
      ),
    );
  }

  Positioned _buildFloatingActionButton() {
    final defaultTopMargin = 256.0 - 4.0;
    final startScale = 96.0;
    final endScale = startScale / 2;

    var top = defaultTopMargin;
    var scale;

    if (scrollController.hasClients) {
      final offset = scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - startScale) {
        scale = 1.0;
      } else if (offset < defaultTopMargin - endScale) {
        scale = (defaultTopMargin - endScale - offset) / endScale;
      } else {
        scale = 0.0;
      }
    }

    return new Positioned(
      child: new Transform.scale(
        scale: scale,
        child: new FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
      top: top,
      right: 16.0,
    );
  }
}
