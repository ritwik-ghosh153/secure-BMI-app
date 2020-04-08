import 'dart:ffi';

class UserData {
  String _id;
  String _pass;
  double _bmi;

  UserData(this._id, this._pass, this._bmi);

  String get id => _id;
  String get pass => _pass;
  double get bmi => _bmi;

  set id(String newId) {
    this._id = newId;
  }

  set pass(String newPass) {
    this._pass = newPass;
  }

  set bmi(double newBmi) {
    this._bmi = newBmi;
  }

  //convert to map
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = _id;
    map['pass'] = _pass;
    map['bmi'] = _bmi;

    return map;
  }

  UserData.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._pass = map['pass'];
    this._bmi = map['bmi'];
  }
}
