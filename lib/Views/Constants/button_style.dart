import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

// ignore: must_be_immutable
class SnowButton extends StatelessWidget {
  Text? text;
  Function onPressed;
  Icon? icon;
  Decoration? decoration;
  double? width;
  double? height;
  Color? color;
  SnowButton(
      {super.key,
      this.text,
      required this.onPressed,
      this.icon,
      this.decoration,
      this.width,
      this.height,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: decoration,
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () {
          onPressed();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text == null ? const Gap(0) : text!,
            icon == null ? const Gap(0) : icon!,
          ],
        ),
      ),
    );
  }
}
