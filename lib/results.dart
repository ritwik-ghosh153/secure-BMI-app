import 'package:crud_app/constants.dart';
import 'package:flutter/material.dart';
import 'reusable_card.dart';
import 'buttons.dart';

class Results extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI', style: kAppBarStyle, ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Text('Your Result:', style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold,),),
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: ReusableCard(
              colour: kActiveCardColour,
              cardChild: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                  ),
                  Text('NORMAL', style: TextStyle(color: Color(0xFF24D876), fontSize: 24, fontWeight: FontWeight.bold),),
                  Text('18.3', style: TextStyle(fontSize: 100, fontWeight: FontWeight.bold),),
                  Text('Interpretation', style: TextStyle(fontSize: 22),),

                ],
              ),
            ),
          ),
          BottomButton(
            title: 'RE-CALCULATE',
            ontap: () => Navigator.pop(context),),
        ],
      ),
    );
  }
}
