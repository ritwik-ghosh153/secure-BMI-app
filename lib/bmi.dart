import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
import 'icon_content.dart';
import 'reusable_card.dart';
import 'constants.dart';


enum Gender { Male, Female }

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  int height=180;
  int weight=60;
  int age=20;
  Gender selectedGender;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    onpress: (){
                      setState(() {
                        selectedGender=Gender.Male;
                      });
                    },
                    colour: selectedGender == Gender.Male
                        ? kActiveCardColour
                        : kInactiveCardColour,
                    cardChild: IconChild(
                      sex: FontAwesomeIcons.mars,
                      label: 'MALE',
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    onpress: (){
                      setState(() {
                        selectedGender=Gender.Female;
                      });
                    },
                    colour: selectedGender == Gender.Female
                        ? kActiveCardColour
                        : kInactiveCardColour,
                    cardChild: IconChild(
                        sex: FontAwesomeIcons.venus, label: 'FEMALE'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ReusableCard(
              colour: kActiveCardColour,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('HEIGHT',
                  style: kLabelTextStyle,),
                  Row(
                    textBaseline: TextBaseline.alphabetic,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: <Widget>[
                      Text(height.toString(),
                        style: kNumberTextStyle,

                      ),
                      Text('cm',
                      style: kLabelTextStyle),
                    ],
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.white,
                      inactiveTrackColor: Color(0xFF8D8E98),
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0,),
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
                      thumbColor: kBottomContainerColour,
                      overlayColor: Color(0x40EB1555),
                    ),
                      child: Slider(
                      value: height.toDouble(),
                      min: 120.0,
                      max: 220.0,
                      onChanged: (double newValue) {
                        setState(() {
                          height = newValue.round();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('WEIGHT',style: kLabelTextStyle,),
                        Text(weight.toString(),
                        style: kNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: (){
                                if(weight>0)
                                setState(() {
                                  weight--;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: (){
                                setState(() {
                                  weight++;
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    colour: kActiveCardColour,
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('AGE',style: kLabelTextStyle,),
                        Text(age.toString(),
                          style: kNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconButton(
                              icon: FontAwesomeIcons.minus,
                              onPressed: (){
                                if(age>0)
                                  setState(() {
                                    age--;
                                  });
                              },
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            RoundIconButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: (){
                                setState(() {
                                  age++;
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    colour: kActiveCardColour,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: kBottomContainerColour,
            height: kBottomContainerHeight,
            width: double.infinity,
            margin: EdgeInsets.only(
              top: 10.0,
            ),
            child: Center(
              child: Text(
                'CALCULATE BMI',
                style: TextStyle(color: Colors.white, fontSize: 23),
              ),
            ),
          )
        ],
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