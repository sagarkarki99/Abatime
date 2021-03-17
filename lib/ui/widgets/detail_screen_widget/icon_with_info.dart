import 'package:flutter/material.dart';

class IconWithInfo extends StatelessWidget {
  final String label;
  final IconData icon;
  const IconWithInfo({Key key, this.label, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 26,
          color: Colors.white70,
        ),
        SizedBox(
          width: 4.0,
        ),
        Text(
          '$label',
          style: Theme.of(context).textTheme.headline5.copyWith(
                fontWeight: FontWeight.w400,
                color: Colors.white70,
              ),
        ),
      ],
    );
  }
}
