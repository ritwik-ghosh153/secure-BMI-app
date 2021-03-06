import 'package:crud_app/constants.dart';
import 'package:flutter/material.dart';
import 'reusable_card.dart';
import 'buttons.dart';


class Results extends StatelessWidget {

  ///class variables
  final String bmi;
  final String result;
  final String interpretation;
  final String previousBmi;
  final Function onpress;


  Results({this.bmi, this.result, this.interpretation, this.previousBmi, this.onpress});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI', style: kAppBarStyle,),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 25.0),
            child: Row(
              children: <Widget>[
                SizedBox(
                width: 10,
              ),
                Text('Previous BMI: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,letterSpacing: 2),),
                Text(previousBmi, style: TextStyle(fontSize: previousBmi=='No BMI calculated earlier'? 14:18, fontWeight: FontWeight.normal, letterSpacing: 2),),
              ],
            ),
          ),
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
                  Text(result, style: TextStyle(color: Color(0xFF24D876), fontSize: 24, fontWeight: FontWeight.bold),),
                  Text(bmi, style: TextStyle(fontSize: 100, fontWeight: FontWeight.bold),),
                  Text(interpretation, style: TextStyle(fontSize: 22),),

              RaisedButton(
                color: kBottomContainerColour,
                shape: kButtonShape,
                child: Text('Do not consider this output'),
                onPressed: onpress,
              ),
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
