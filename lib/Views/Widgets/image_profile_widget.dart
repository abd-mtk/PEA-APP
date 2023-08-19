import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pea/Views/Constants/style.dart';

import '../Constants/fonts.dart';

class ImageWidget extends StatelessWidget {
  final File? image;
  final String? name;
  final TextStyle? textStyle;
  final bool isPost;

  const ImageWidget({
    Key? key,
    required this.image,
    this.name,
    this.textStyle,
    this.isPost = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            const Gap(10),
            isPost
                ? Container(
                    decoration: snowContainer,
                    child: image == null
                        ? Image.asset(
                            "assets/images/unknown.png",
                            fit: BoxFit.cover,
                            width: Get.width * 0.95,
                            height: Get.height * 0.3,
                          )
                        : image!.path.contains("http")
                            ? Image.network(
                                image!.path,
                                fit: BoxFit.cover,
                                width: Get.width * 0.95,
                                height: Get.height * 0.3,
                                scale: 0.5,
                              )
                            : Image.file(
                                image!,
                                fit: BoxFit.cover,
                                width: Get.width * 0.95,
                                height: Get.height * 0.3,
                                scale: 0.5,
                              ),
                  )
                : image == null
                    ? CircleAvatar(
                        backgroundImage:
                            const AssetImage("assets/images/unknown.png"),
                        radius: Get.width * 0.20,
                      )
                    : !image!.path.contains("http")
                        ? CircleAvatar(
                            backgroundImage: FileImage(File(image!.path)),
                            radius: Get.width * 0.20,
                          )
                        : CircleAvatar(
                            backgroundImage: NetworkImage(image!.path),
                            radius: Get.width * 0.20,
                          ),
            name != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: name != null
                        ? Text(
                            name!,
                            style: textStyle ?? titleTextStylew,
                          )
                        : null,
                  )
                : const Gap(0),
          ],
        ),
      ],
    );
  }
}
