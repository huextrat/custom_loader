library custom_loader;

import 'package:flutter/material.dart';

class CustomLoader extends StatefulWidget {
  final Widget child;
  final AnimationController animationController;
  final Animation<double> animation;
  const CustomLoader({
    @required this.child,
    this.animationController,
    this.animation
  });

  @override
  _CustomLoaderState createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader> with SingleTickerProviderStateMixin {
  AnimationController myAnimationController;
  Animation<double> myAnimation;

  @override
  void initState() {
    super.initState();
    myAnimationController = AnimationController(
        vsync: this, duration: const Duration(seconds: 3), reverseDuration: const Duration(seconds: 3))
      ..addListener(() => setState(() {}));
    myAnimation = CurvedAnimation(
      parent: myAnimationController,
      curve: Curves.ease,
    );

    myAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        myAnimationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        myAnimationController.forward();
      }
    });

    myAnimationController.forward();
  }

  @override
  void dispose() {
    myAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RotationTransition(
        turns: widget.animation ?? myAnimation,
        child: widget.child,
      ),
    );
  }
}
