import 'package:flutter/material.dart';
import 'package:custom_loader/custom_loader.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Loader Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Custom Loader Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  AnimationController customAnimationController;
  Animation<double> customAnimation;

  @override
  void initState() {
    super.initState();
    customAnimationController = AnimationController(
        vsync: this, duration: const Duration(seconds: 3), reverseDuration: const Duration(seconds: 3))
      ..addListener(() => setState(() {}));
    customAnimation = CurvedAnimation(
      parent: customAnimationController,
      curve: Curves.elasticIn,
    );

    customAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        customAnimationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        customAnimationController.forward();
      }
    });

    customAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CustomLoader(
            child: Image.asset(
              'assets/flutter_logo.png',
              height: 60,
            ),
            animation: customAnimation,
            animationController: customAnimationController,
          ),
          CustomLoader(
            child: SvgPicture.asset(
              'assets/flutter_logo.svg',
              height: 60,
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
