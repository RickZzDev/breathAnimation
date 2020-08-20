import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController animController;
  double animValue = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    functionAnimation();
  }

  @override
  void dispose() {
    if (animController.status == AnimationStatus.forward ||
        animController.status == AnimationStatus.dismissed) {
      animController.notifyStatusListeners(AnimationStatus.dismissed);
    }
    animController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void functionAnimation() {
    animController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animController.forward();
        // mounted ? animController.forward() : null;
      }
    });

    animController.addListener(() {
      setState(() {
        animValue = animController.value;
      });
    });

    animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = 250.0 - animValue * 10.0;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: size,
              width: size,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(50),
              ),
            )
          ],
        ),
      ),
    );
  }
}
