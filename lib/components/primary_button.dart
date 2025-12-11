import 'package:flutter/material.dart';


class PrimaryButton extends StatelessWidget {
  PrimaryButton({super.key, required this.text, required this.onPressed});

  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(onPressed: () {
      onPressed();
    }, child: Text(text));

  }
}
