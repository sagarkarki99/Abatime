import 'package:flutter/material.dart';

class SlideTransitionContainer extends StatefulWidget {
  final Widget? child;

  const SlideTransitionContainer({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  _SlideTransitionContainerState createState() =>
      _SlideTransitionContainerState();
}

class _SlideTransitionContainerState extends State<SlideTransitionContainer>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 1000,
      ),
    );
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SlideTransition(
        position: Tween(
          begin: Offset(0, 0.05),
          end: Offset(0, 0),
        ).animate(CurvedAnimation(
          parent: animationController,
          curve: Curves.bounceOut,
        )),
        child: widget.child,
      ),
    );
  }
}
