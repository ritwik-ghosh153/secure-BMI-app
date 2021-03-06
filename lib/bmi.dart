import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_app/bmiCalculator.dart';
import 'package:crud_app/results.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'icon_content.dart';
import 'reusable_card.dart';
import 'constants.dart';
import 'buttons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

enum Gender { Male, Female }

class InputPage extends StatefulWidget {

  final String id;
  ///constructor
  InputPage({this.id});


  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  ///class variables
  int height=180;
  int weight=60;
  int age=20;
  Gender selectedGender;
  bool hasPrevious=false;
  String _previousBmi;
  var bmi;

  @override
  void initState(){
    super.initState();
    getCurrentUser();
  }

  final _firestore= Firestore.instance;
  FirebaseUser _currentUser;
  final _auth = FirebaseAuth.instance;


  void getCurrentUser() async{
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        _currentUser = user;
      }
      else
        Navigator.pop(context);
    }
    catch(e){
      print(e);
      Navigator.pop(context);
    }
  }

  void fetch() async{
    final bmis= await _firestore.collection(_currentUser.email).getDocuments();
    for(bmi in bmis.documents)
      {
        if(bmi.data['user']==_currentUser.email) {
          hasPrevious=true;
          _previousBmi=bmi.data['bmi'];
          break;
        }
      }
    if(!hasPrevious){
      _previousBmi='No BMI calculated earlier';
    }
  }
  ///widget tree

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: ()async{
        await Alert(
          style: AlertStyle(
            backgroundColor: Colors.white,
          ),
          context: context,
          title: 'Logged out!!',
          desc: 'Going to the previous screen has logged you out safely.',
          buttons: [
            DialogButton(
              child: Text('OKAY',
                style: TextStyle(
                    color: Colors.blue[900], fontSize: 20),
              ),
              onPressed: () async {
                Navigator.pop(context);
                await _auth.signOut();
              },
              width: 120,
            ),
          ],
        ).show();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('BMI CALCULATOR', style: kAppBarStyle,),
          leading: null,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.close, color: Colors.white,),
                onPressed: (){
                  ///logout button
                  Alert(
                    style: AlertStyle(
                      backgroundColor: Colors.white,
                    ),
                    context: context,
                    title: 'Log out!!',
                    desc: 'This will log you out. proceed?',
                    buttons: [
                      DialogButton(
                        child: Text('Log Out',
                          style: TextStyle(
                              color: Colors.blue[900], fontSize: 20),
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                          await _auth.signOut();
                          Navigator.pop(context);
                        },
                        width: 120,
                      ),
                      DialogButton(
                        child: Text('Stay',
                          style: TextStyle(
                              color: Colors.blue[900], fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        width: 120,
                      )
                    ],
                  ).show();

                },
              )
            ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Logged in as '+widget.id, textAlign: TextAlign.center,),
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
            BottomButton(title: 'CALCULATE BMI',
                ontap: () async{
              ///gets current user
              await fetch();
              BmiCalculator calc= BmiCalculator(height: this.height, weight: this.weight);
              String currentBmi=calc.calculate();
              _firestore.collection(_currentUser.email).document('hello').setData({
                'bmi':currentBmi,
                'user':_currentUser.email
              });
              ///sends data to the results pahe for displaying
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => Results(
                  bmi:currentBmi,
                  result: calc.getResult(),
                  interpretation: calc.getInterpretation(),
                  previousBmi: _previousBmi,
                  //deletion
                  onpress: (){
                    _firestore.collection(_currentUser.email).document('hello').delete();
                    Navigator.pop(context);
                  },
                )
              ),);
            },)
          ],
        ),
      ),
    );
  }
}
