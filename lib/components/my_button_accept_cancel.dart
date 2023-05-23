import 'package:flutter/material.dart';

class ButtonAcceptCancel extends StatelessWidget {
  final String texto;
  final Color backgroundColor;
  final Color fontColor;
  const ButtonAcceptCancel(
      {super.key,
      required this.texto,
      required this.backgroundColor,
      required this.fontColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 50,
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(30)),
      child: Center(
        child: Text(
          texto,
          style: TextStyle(color: fontColor),
        ),
      ),
    );
  }
}
