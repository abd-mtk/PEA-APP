import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Constants/fonts.dart';

// ignore: must_be_immutable
class TextSection extends StatelessWidget {
  final String? text;
  int? lines;
  TextSection({Key? key, required this.text, this.lines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        width: Get.width * 0.95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black,
          ),
          color: Colors.grey[300],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text ?? '',
            style: subtitleTextStyle,
            maxLines: lines,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
        ),
      ),
    );
  }
}
