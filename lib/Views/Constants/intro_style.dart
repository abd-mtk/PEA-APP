import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

DotsDecorator dotstyle = DotsDecorator(
  size: const Size.square(10.0),
  activeSize: const Size(30.0, 12.0),
  color: Colors.black26,
  activeColor: Colors.green,
  spacing: const EdgeInsets.symmetric(horizontal: 3.0),
  activeShape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
);

const TextStyle buttonstyle =  TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.w600,
                fontSize: 18.0,
                fontFamily: 'Montserrat',
                fontStyle: FontStyle.italic);
