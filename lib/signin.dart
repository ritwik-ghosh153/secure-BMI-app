import 'package:flutter/material.dart';
import 'reusable_card.dart';
import 'constants.dart';
import 'textInnput.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'bmi.dart';

class SignInPage extends StatelessWidget {

  ///class variables
  final TextInput _id = TextInput(passwordType: false, placeholder: 'Enter your email',);
  final TextInput _pass = TextInput(passwordType: true, placeholder: 'Enter your assword',);
  final TextInput _repass= TextInput(passwordType: true, placeholder: 'Re-enter your Password',);

  final _auth = FirebaseAuth.instance;
  FirebaseUser _currentUser;

  ///method to fetch current user and wait until there is response from firebase cloud
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

  ///Defining the widget tree
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up', style: kAppBarStyle,),
        ),
        body: ReusableCard(
          cardChild: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
                      child: Text('Let\'s create your account!', style: kHeadingStyle.copyWith(fontSize: 30), textAlign: TextAlign.center,
                      ),
                    ),
                    //Login credentials
                    // Login id
                    _id,
                    //Password
                    _pass,
                    //Re-enter password
                    _repass,
                    //Log in button
                    RaisedButton(
                      color: kRoundedButtonColour,
                        shape: kButtonShape,
                        child: Text('Create account'),
                        onPressed: () async{
                          if(_id.getText()=='' || _pass.getText()=='' || _repass.getText()==''){
                            ///Alert if fields are empty
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
                                    'OKAY',
                                    style: TextStyle(color: Colors.blue[900], fontSize: 20),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  width: 120,
                                )
                              ],
                            ).show();
                          }
                          else if(_pass.getText()!=_repass.getText()){
                            ///Alert if passwords do not match
                            Alert(
                              style: AlertStyle(
                                backgroundColor: Colors.white,
                              ),
                              context: context,
                              title: 'OOPS!!',
                              desc: 'The passwords do not match :(',
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "OKAY",
                                    style: TextStyle(color: Colors.blue[900], fontSize: 20),
                                  ),
                                  onPressed: () { Navigator.pop(context);},
                                  width: 120,
                                )
                              ],
                            ).show();
                          }
                          else {
                            try {
                              final newUser = await _auth.createUserWithEmailAndPassword(
                                  email: _id.getText(),
                                  password: _pass.getText());
                              if(newUser!=null) {
                                ///pop up to say we have registered
                                Alert(
                                  style: AlertStyle(
                                    backgroundColor: Colors.white,
                                  ),
                                  context: context,
                                  title: 'Success!!',
                                  desc: 'Your account has been created :)',
                                  buttons: [
                                    DialogButton(///Takes back to home screen
                                      child: Text(
                                        "OKAY",
                                        style: TextStyle(
                                            color: Colors.blue[900], fontSize: 20),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      width: 120,
                                    ),
                                    DialogButton(///Takes to BMI calculator
                                      child: Text(
                                        "Log in",
                                        style: TextStyle(
                                            color: Colors.blue[900], fontSize: 20),
                                      ),
                                      onPressed: () async{
                                        try {
                                          final user = await _auth
                                              .signInWithEmailAndPassword(
                                              email: _id.getText(),
                                              password: _pass.getText());
                                          if (user != null) {
                                            await getCurrentUser();
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.push(
                                                context, MaterialPageRoute(
                                                builder: (context) =>
                                                    InputPage(
                                                        id: _currentUser.email)

                                            ));
                                          }
                                        }
                                        catch(e)
                                        {
                                          ///pop up if sign in fails due to internet
                                          Alert(
                                            style: AlertStyle(
                                              backgroundColor: Colors.white,
                                            ),
                                            context: context,
                                            title: 'Login failed!!',
                                            desc: 'Check your internet connection',
                                          ).show();
                                        }
                                      },
                                      width: 120,
                                    )
                                  ],
                                ).show();
                              }
                            }
                            catch(e){///Catching and dealing with various errors thrown by firebase
                              switch(e.code){
                                ///previous user
                                case 'ERROR_EMAIL_ALREADY_IN_USE':
                                  Alert(
                                    style: AlertStyle(
                                      backgroundColor: Colors.white,
                                    ),
                                    context: context,
                                    title: 'You\'ve been here before!!',
                                    desc: 'User already exists. Try logging in instead?',
                                    buttons: [
                                      DialogButton(
                                        child: Text(
                                          "OKAY",
                                          style: TextStyle(color: Colors.blue[900], fontSize: 20),
                                        ),
                                        onPressed: () { Navigator.pop(context); Navigator.pop(context);},
                                        width: 120,
                                      )
                                    ],
                                  ).show();
                                  break;
                                  ///not email
                                case 'ERROR_INVALID_EMAIL':
                                  Alert(
                                    style: AlertStyle(
                                      backgroundColor: Colors.white,
                                    ),
                                    context: context,
                                    title: 'Incorrect email!!',
                                    desc: 'Try checking the email entered :)',
                                    buttons: [
                                      DialogButton(
                                        child: Text(
                                          "OKAY",
                                          style: TextStyle(color: Colors.blue[900], fontSize: 20),
                                        ),
                                        onPressed: () { Navigator.pop(context);},
                                        width: 120,
                                      )
                                    ],
                                  ).show();
                                  break;
                                  ///weak password used
                                case 'ERROR_WEAK_PASSWORD':
                                  Alert(
                                    style: AlertStyle(
                                      backgroundColor: Colors.white,
                                    ),
                                    context: context,
                                    title: 'Weak password!!',
                                    desc: 'Try with a longer password, password should be greater than 6 characters',
                                    buttons: [
                                      DialogButton(
                                        child: Text(
                                          "OKAY",
                                          style: TextStyle(color: Colors.blue[900], fontSize: 20),
                                        ),
                                        onPressed: () { Navigator.pop(context);},
                                        width: 120,
                                      )
                                    ],
                                  ).show();
                                  break;
                              }
                              print(e);
                              print(e.hashCode);
                            }
                          }
                        }),
                  ],
                ),
              ),
            ],
          ),
          colour: kActiveCardColour,
        )
    );
  }
}
