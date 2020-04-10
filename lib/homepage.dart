import 'package:crud_app/bmi.dart';
import 'package:crud_app/constants.dart';
import 'package:crud_app/reusable_card.dart';
import 'package:crud_app/textInnput.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';

///shows us the login page
class HomePage extends StatelessWidget {
  ///for taking inputs
  final TextInput _id = TextInput(passwordType: false, placeholder: 'Enter your email',);
  final TextInput _pass = TextInput(passwordType: true, placeholder: 'Enter your password',);

  ///firebase auth instance for authentication of user
  final _auth = FirebaseAuth.instance;
  FirebaseUser _currentUser;

  ///gets the user who just logged in
  void getCurrentUser() async{
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        _currentUser = user;
      }
    }
    catch(e){
      print(e);
    }
  }

/// building the widget tree
  @override
  Widget build(BuildContext context) {
    TextEditingController _idcontroller =_id.getController();
    TextEditingController _passcontroller = _pass.getController();
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
                  ///Login credentials
                  /// Login id
                  _id,
                  ///Password
                  _pass,
                  ///Log in button
                  RaisedButton(
                    color: kRoundedButtonColour,
                      shape: kButtonShape,
                      child: Text('Log in'),
                      onPressed: () async{
                        if (_id.getText() == '' || _pass.getText() == '') {
                          /// pop up if not all fields are filled
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
                                      color: Colors.blue[900], fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                                width: 120,
                              )
                            ],
                          ).show();
                        }
                        else {
                          try {
                            ///signing in
                            final user = await _auth.signInWithEmailAndPassword(
                                email: _id.getText(),
                                password: _pass.getText());
                            if(user!=null) {
                              _idcontroller.clear();
                              _passcontroller.clear();
                              await getCurrentUser();
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => InputPage(id: _currentUser.email)

                              ));
                            }
                          }
                          catch(e)
                        {
                          ///alert if login fails due to invalid credentials
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
                                      color: Colors.blue[900], fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                                width: 120,
                              )
                            ],
                          ).show();
                        }
                        }
                      }),
                  ///sign up button
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

