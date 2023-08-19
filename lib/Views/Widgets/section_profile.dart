import 'package:flutter/material.dart';

import '../Constants/fonts.dart';

// ignore: must_be_immutable
class SectionProfile extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget? child;
  int? maxLines;
   SectionProfile({
    Key? key,
    this.title,
    this.subtitle,
    this.child,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              title ?? "",
              style: hintStyle,
              textAlign: TextAlign.right,
              maxLines: 1,
            ),
            Text(
              subtitle ?? "",
              style: subtitleTextStyle,
              maxLines: maxLines ?? 1,
              textAlign: TextAlign.right,
            ),
            child ?? const SizedBox(),
            const Divider(
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
