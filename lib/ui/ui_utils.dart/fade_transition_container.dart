import 'package:flutter/material.dart';

class FadeTransitionContainer extends StatefulWidget {
  Widget? child;

  FadeTransitionContainer({this.child});

  @override
  _FadeTransitionContainerState createState() =>
      _FadeTransitionContainerState();
}

class _FadeTransitionContainerState extends State<FadeTransitionContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: widget.child,
    );
  }
}
