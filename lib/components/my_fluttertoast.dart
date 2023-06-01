import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<Future<bool?>> myCustomFlutterToast(String texto, Color color) async {
  return Fluttertoast.showToast(
      msg: texto,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}
