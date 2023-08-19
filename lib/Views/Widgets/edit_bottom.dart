import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class EditButton extends StatelessWidget {
  Icon icon;
  String text;
  Color color;
  Color? backgroundColor = Colors.white;
  Function() onPressed;

  EditButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.color,
    this.backgroundColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Get.width * 0.22,
          height: Get.width * 0.22,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: IconButton(onPressed: onPressed, icon: icon),
        ),
        Text(
          text,
          style: TextStyle(
              color: color, fontSize: 16, fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
