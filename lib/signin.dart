import 'package:flutter/material.dart';
import 'reusable_card.dart';
import 'constants.dart';
import 'textInnput.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SignInPage extends StatelessWidget {
  final TextInput id = TextInput(passwordType: false,);
  final TextInput pass = TextInput(passwordType: true,);
  final TextInput repass= TextInput(passwordType: true,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
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
                      child: Text('Let\'s create your account!', style: kLabelTextStyle.copyWith(fontSize: 25),
                      ),
                    ),
                    //Login credentials
                    // Login id
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text('New login id:', style: TextStyle(fontSize: 30.0),
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
                          child: Text('Set password:', style: TextStyle(fontSize: 30.0)),
                        ),
                      ],
                    ),
                    pass,
                    //Re-enter password
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text('Re-enter password:', style: TextStyle(fontSize: 30.0)),
                        ),
                      ],
                    ),
                    repass,
                    //Log in button
                    RaisedButton(
                        shape: kButtonShape,
                        child: Text('Create account'),
                        onPressed: () {
                          if(id.getText()=='' || pass.getText()=='' || repass==''){
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
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  width: 120,
                                )
                              ],
                            ).show();
                          }
                          else if(pass.getText()!=repass.getText()){
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
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () { Navigator.pop(context); Navigator.pop(context);},
                                  width: 120,
                                )
                              ],
                            ).show();
                          }
                          else {
                            //TODO: check database for duplicates, insert new row into database
                            //TODO: alert that account has been created
                            Alert(
                              style: AlertStyle(
                                backgroundColor: Colors.white,
                              ),
                              context: context,
                              title: 'Success!!',
                              desc: 'Your account has been created :)',
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "OKAY",
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () { Navigator.pop(context); Navigator.pop(context);},
                                  width: 120,
                                ),
                                DialogButton(
                                  child: Text(
                                    "Log in",
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pushNamed(context, '/bmi');},
                                  width: 120,
                                )
                              ],
                            ).show();
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
