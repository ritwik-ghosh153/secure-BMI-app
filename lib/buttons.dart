import 'package:flutter/material.dart';
import 'constants.dart';

class BottomButton extends StatelessWidget {

  final Function ontap;
  final String title;
  BottomButton({@required this.title, @required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.only(bottom: 15.0),
        color: kBottomContainerColour,
        height: kBottomContainerHeight,
        width: double.infinity,
        margin: EdgeInsets.only(
          top: 10.0,
        ),
        child: Center(
          child: Text(title,
            style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}


class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;
  RoundIconButton({this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: CircleBorder(),
      onPressed: onPressed,
      child: Icon(icon),
      elevation: 0.0,
      constraints: BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,
      ),
      fillColor: Color(0xFF4C4F5E) ,
    );
  }
}