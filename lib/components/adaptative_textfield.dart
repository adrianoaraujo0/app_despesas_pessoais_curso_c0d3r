import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextField extends StatelessWidget {

  TextEditingController controller = TextEditingController();
  String label;
  TextInputType textInputType;

  AdaptativeTextField({
    required this.controller,
    required this.label,
    required this.textInputType,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS 
    ? CupertinoTextField(
        controller: controller,
        placeholder: label,
        keyboardType: textInputType,
    )
    : TextField(
         controller: controller,
         decoration: InputDecoration(labelText: label),
         keyboardType: textInputType,
      );
  }
}