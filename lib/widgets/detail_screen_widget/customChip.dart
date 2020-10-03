import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final Color color;

  const CustomChip({Key key, this.label, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          border: Border.all(
            color: color,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(16)),
      child: Text(
        '$label',
        style: Theme.of(context).textTheme.caption.copyWith(
              letterSpacing: 2.0,
              color: color,
            ),
      ),
    );
  }
}
