import 'package:flutter/material.dart';

import 'icon_with_info.dart';

class MovieStatInfo extends StatefulWidget {
  final String label;
  final IconData iconData;

  const MovieStatInfo({
    Key? key,
    required this.label,
    required this.iconData,
  }) : super(key: key);

  @override
  _MovieStatInfoState createState() => _MovieStatInfoState();
}

class _MovieStatInfoState extends State<MovieStatInfo>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(1, 0),
        end: Offset.zero,
      ).animate(_animationController),
      child: IconWithInfo(
        label: widget.label,
        icon: widget.iconData,
      ),
    );
  }
}
