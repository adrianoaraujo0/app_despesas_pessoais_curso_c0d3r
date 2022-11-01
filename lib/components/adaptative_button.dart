import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {

  final String label;
  final Function onPressed;

  const AdaptativeButton({
    required this.onPressed ,
    required this.label ,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
    ? CupertinoButton(
        onPressed: (() => onPressed()),
        color: Colors.purple,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
        child: Text(label, style: const TextStyle(fontSize: 15),),
    )
    : ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(color: Theme.of(context).textTheme.button!.color),
        backgroundColor: Theme.of(context).primaryColor),
      onPressed: onPressed(),
      child: Text(label),
    );
  }
}