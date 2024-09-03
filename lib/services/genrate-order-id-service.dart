import 'dart:math';

String genrateOrderId(){
  DateTime now=DateTime.now();

  int randomNumber=Random().nextInt(9999);
  String id='${now.microsecondsSinceEpoch}$randomNumber';
  return id;
}