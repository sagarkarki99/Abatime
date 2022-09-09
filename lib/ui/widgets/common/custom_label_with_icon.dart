import 'package:flutter/material.dart';

class CustomLabelWithIcon extends StatelessWidget {
  final String? label;
  final Color labelColor;
  final IconData? icon;
  final Color iconColor;

  CustomLabelWithIcon(
      {Key? key,
      this.label,
      this.icon,
      this.labelColor = Colors.white,
      this.iconColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 52.0,
          color: iconColor.withOpacity(0.5),
        ),
        SizedBox(height: 8.0),
        Text(
          label!,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: labelColor.withOpacity(0.5),
              ),
        )
      ],
    ));
  }
}
