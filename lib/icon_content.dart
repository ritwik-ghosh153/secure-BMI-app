import 'package:flutter/material.dart';
import 'constants.dart';

class IconChild extends StatelessWidget {
  final sex;
  final label;
  IconChild({@required this.sex, @required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          sex,
          size: 80.0,
        ),
        SizedBox(
          height: 15,
        ),
        Text(label, style: kLabelTextStyle),
      ],
    );
  }
}