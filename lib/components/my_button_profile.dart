import 'package:flutter/material.dart';

class MyButtonProfile extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color backgroundColor;

  const MyButtonProfile({
    super.key,
    this.onTap,
    required this.text,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 80),
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(50)),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
