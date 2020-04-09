import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {

  final bool passwordType;
  final String placeholder;
  final TextEditingController _myController = TextEditingController();

  TextInput({@required this.passwordType, @required this.placeholder});

  String getText() {
    return _myController.text;
  }

  TextEditingController getController() {
    return _myController;
  }

//  TextInput({@required this.myController});

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    widget._myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40,0,40,20),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 2,
          ),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: widget.placeholder,
          ),
          controller: widget._myController,
          obscureText: widget.passwordType,
        ),
      ),
    );
  }

}