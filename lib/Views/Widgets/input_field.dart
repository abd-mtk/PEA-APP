import 'package:flutter/material.dart';

import '../Constants/colors.dart';
import '../Constants/fonts.dart';
import '../Constants/style.dart';

// ignore: must_be_immutable
class InputField extends StatelessWidget {
  TextEditingController inputController = TextEditingController();
  String hintText;
  IconData? prefixicon;
  dynamic suffixicon;
  bool showPassword;
  int maxchar = 20;
  String defultValue;
  int maxLines;
  TextDirection textDirection = TextDirection.ltr;
  TextAlign textAlign = TextAlign.left;
  InputField({
    Key? key,
    required this.hintText,
    this.prefixicon,
    this.suffixicon,
    required this.inputController,
    required this.showPassword,
    required this.maxchar,
    required this.defultValue,
    this.maxLines = 1,
    this.textDirection = TextDirection.ltr,
    this.textAlign = TextAlign.left,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InputDecoration inputDecoration = InputDecoration(
      prefixIcon: Icon(
        prefixicon,
        color: primeColor,
        size: 25,
      ),
      suffixIcon: suffixicon,
      hintText: hintText,
      hintTextDirection: textDirection,
      border: border,
      focusedBorder: focusedBorder,
      disabledBorder: disabledBorder,
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        keyboardType: TextInputType.text,
        textAlign: textAlign,
        obscureText: showPassword,
        decoration: inputDecoration,
        cursorHeight: 25,
        style: inputStyle,
        controller: inputController,
        maxLength: maxchar,
        maxLines: maxLines,
      ),
    );
  }
}
