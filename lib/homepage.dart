import 'package:crud_app/constants.dart';
import 'package:crud_app/reusable_card.dart';
import 'package:crud_app/textInnput.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomePage extends StatelessWidget {
  final TextInput id = TextInput();
  final TextInput pass = TextInput();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Login Page'),
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
                      style: kLabelTextStyle.copyWith(fontSize: 25),
                    ),
                  ),
                  //Login credentials
                  // Login id
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          'Login id:',
                          style: TextStyle(fontSize: 30.0),
                        ),
                      ),
                    ],
                  ),
                  id,
                  //Password
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child:
                            Text('Password:', style: TextStyle(fontSize: 30.0)),
                      ),
                    ],
                  ),
                  pass,
                  //Log in button
                  RaisedButton(
                      shape: kButtonShape,
                      child: Text('Log in'),
                      onPressed: () {
                        if (id.getText() == '' || pass.getText() == '') {
                          Alert(
                            style: AlertStyle(
                              backgroundColor: Colors.white,
                            ),
                            context: context,
                            title: 'OOPS!!',
                            desc: 'All the fields are required!',
                            buttons: [
                              DialogButton(
                                child: Text(
                                  "OKAY",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                                width: 120,
                              )
                            ],
                          ).show();
                        }
                        //TODO: search database for matching id and pass
                        //TODO: push to bmi page
                      }),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: RaisedButton(
                      child: Text('New here? Sign up!'),
                      shape: kButtonShape,
                      onPressed: () {
                        Navigator.pushNamed(context, '/signin');
                        //TODO: move to sign up page
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: RaisedButton(
                  child: Text('Delete account'),
                  shape: kButtonShape,
                  color: Colors.red,
                  onPressed: () {
                    //TODO: move to delete account page up page
                  },
                ),
              ),
            ),
          ],
        ),
        colour: kActiveCardColour,
      ),
    );
  }
}