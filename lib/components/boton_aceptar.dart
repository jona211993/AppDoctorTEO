import 'package:flutter/material.dart';
class ElevateButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ElevateButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
     
    );
  }
}