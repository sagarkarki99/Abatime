import 'package:flutter/material.dart';

class CustomChip extends StatefulWidget {
  final String? label;
  final Color? color;

  const CustomChip({Key? key, this.label, this.color}) : super(key: key);

  @override
  _CustomChipState createState() => _CustomChipState();
}

class _CustomChipState extends State<CustomChip>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: Container(
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            border: Border.all(
              color: widget.color!,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(16)),
        child: Text(
          '${widget.label}',
          style: Theme.of(context).textTheme.caption!.copyWith(
                letterSpacing: 2.0,
                color: widget.color,
              ),
        ),
      ),
    );
  }
}
