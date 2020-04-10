import 'package:crud_app/constants.dart';
import 'package:crud_app/reusable_card.dart';
import 'package:crud_app/textInnput.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  final TextInput _id = TextInput(passwordType: false, placeholder: 'Enter your email',);
  final TextInput _pass = TextInput(passwordType: true, placeholder: 'Enter your password',);

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Login Page', style: kAppBarStyle,),
      ),
      body: ReusableCard(
        cardChild: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
                    child: Text(
                      'Log in here',
                      style: kHeadingStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  //Login credentials
                  // Login id
                  _id,
                  //Password
                  _pass,
                  //Log in button
                  RaisedButton(
                    color: kRoundedButtonColour,
                      shape: kButtonShape,
                      child: Text('Log in'),
                      onPressed: () async{
                        if (_id.getText() == '' || _pass.getText() == '') {
                          Alert(
                            style: AlertStyle(
                              backgroundColor: Colors.white,
                            ),
                            context: context,
                            title: 'OOPS!!',
                            desc: 'All the fields are required!',
                            buttons: [
                              DialogButton(
                                child: Text('OKAY',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                                width: 120,
                              )
                            ],
                          ).show();
                        }
                        else {
                          try {
                            final user = await _auth.signInWithEmailAndPassword(
                                email: _id.getText(),
                                password: _pass.getText());
                            if(user!=null) {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, '/home');
                              Navigator.pushNamed(context, '/bmi');
                            }
                          }
                          catch(e)
                        {
                          Alert(
                            style: AlertStyle(
                              backgroundColor: Colors.white,
                            ),
                            context: context,
                            title: 'Login failed!!',
                            desc: 'Invalid username or password :(',
                            buttons: [
                              DialogButton(
                                child: Text('OKAY',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                                width: 120,
                              )
                            ],
                          ).show();
                        }
                        }
                      }),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: RaisedButton(
                      color: kRoundedButtonColour,
                      child: Text('New here? Sign up!'),
                      shape: kButtonShape,
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                    ),
                  ),
                ],
              ),
            ),
//            Expanded(
//              child: Center(
//                child: RaisedButton(
//                  child: Text('Delete account'),
//                  shape: kButtonShape,
//                  color: Colors.red,
//                  onPressed: () {
//                    Navigator.pushNamed(context, '/delete');
//                  },
//                ),
//              ),
//            ),
          ],
        ),
        colour: kActiveCardColour,
      ),
    );
  }
}

