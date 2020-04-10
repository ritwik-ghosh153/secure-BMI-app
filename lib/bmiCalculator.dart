import 'dart:math';

import 'bmi.dart';

class BmiCalculator{
  BmiCalculator({this.height, this.weight});
  final int height;
  final int weight;
  double _bmi;


  String calculate(){
    _bmi=weight/ pow(height/100,2);
    return _bmi.toStringAsFixed(1);
  }
  String getResult(){
    if(_bmi>=25){
      return 'Overweight';
    }
    else if(_bmi>=18.5){
      return 'Normal';
    }
    else
      return 'Underweight';
  }

  String getInterpretation(){
    if(_bmi>=25){
      return 'You have greater than optimal BMI';
    }
    else if(_bmi>=18.5){
      return 'Your BMI is perfectly normal';
    }
    else
      return 'Your have lower than optimal BMI';
  }
}