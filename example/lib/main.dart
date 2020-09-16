import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lifecycle_widget/lifecycle_widget.dart';

void main() {
  LifecycleWidget.debugLog = true;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool m = false;
  int prop = 42;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
            child: Text('mount'),
            onPressed: () {
              setState(() {
                m = true;
              });
            },
          ),
          FlatButton(
            child: Text('unmount'),
            onPressed: () {
              setState(() {
                m = false;
              });
            },
          ),
          FlatButton(
            child: Text('update'),
            onPressed: () {
              setState(() {
                prop = Random().nextInt(100);
              });
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [if (m) TestWidget(prop: prop)],
      ),
    );
  }
}

class TestWidget extends LifecycleWidget {
  final int prop;

  const TestWidget({Key key, this.prop}) : super(key: key);

  void notify(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  @override
  void didMount(BuildContext context) {
    notify(context, 'did mount');
    super.didMount(context);
  }

  @override
  void didUpdate(
    BuildContext context,
    covariant TestWidget oldWidget,
    covariant TestWidget widget,
  ) {
    notify(context, 'update ${oldWidget.prop} => ${widget.prop}');
    super.didUpdate(context, oldWidget, widget);
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("number is $prop"));
  }
}
