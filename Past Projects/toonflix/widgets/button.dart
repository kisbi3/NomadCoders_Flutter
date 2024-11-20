import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Color bgcolor;
  final Color textColor;

  const Button({
    // key는 나중에 설명할 것이다.
    super.key,
    required this.text,
    required this.bgcolor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgcolor,
        borderRadius: BorderRadius.circular(45),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 40,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
