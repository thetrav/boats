import 'package:flutter/material.dart';

class ErrorBox extends StatelessWidget {
  final String text;

  const ErrorBox(this.text);

  @override
  Widget build(BuildContext context) => Container(
    color: Colors.red,
    child: Text(text, style:
    Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white)
    )
  );
}

