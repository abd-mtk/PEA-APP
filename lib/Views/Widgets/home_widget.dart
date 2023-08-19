import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pea/Views/Constants/style.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../Models/event.dart';
import 'text_section.dart';

// ignore: must_be_immutable
class HomeWidget extends StatefulWidget {
  Event? event;
  Function() onShowProfile;
  Function() onLocation;
  HomeWidget({
    Key? key,
    this.event,
    required this.onShowProfile,
    required this.onLocation,
  }) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  bool showDetails = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  showFlexibleBottomSheet(
                    minHeight: 0,
                    initHeight: 0.5,
                    maxHeight: 1,
                    context: context,
                    builder: (
                      BuildContext context,
                      ScrollController scrollController,
                      double bottomSheetOffset,
                    ) {
                      return Container(
                        decoration: snowContainer,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("التفاصيل",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                            const Divider(
                              color: Colors.blue,
                              thickness: 2,
                            ),
                            const Gap(50),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    ZoomTapAnimation(
                                      onTap: widget.onLocation,
                                      child: Image.asset(
                                          "assets/images/place.png",
                                          height: 80,
                                          width: 80,
                                          fit: BoxFit.scaleDown),
                                    ),
                                    const Text(
                                      "الانتقال الى موقع الحدث",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    ZoomTapAnimation(
                                      onTap: widget.onShowProfile,
                                      child: Image.asset(
                                          "assets/images/user.png",
                                          height: 80,
                                          width: 80,
                                          fit: BoxFit.scaleDown),
                                    ),
                                    const Text(
                                      "عرض الملف الشخصي",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    anchors: [0, 0.5, 1],
                    isSafeArea: true,
                    bottomSheetColor: Colors.transparent,
                  );
                },
                icon: const Icon(Icons.dehaze_rounded)),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.event!.title == null || widget.event!.title!.isEmpty
                        ? 'لا يوجد عنوان'
                        : widget.event!.title!,
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(
          color: Colors.grey,
          thickness: 0.5,
        ),
        Image.network(widget.event!.image!,
            fit: BoxFit.cover, height: Get.height * 0.4),
        const Divider(
          color: Colors.grey,
          thickness: 0.5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.timer,
                color: widget.event!.endDate!.compareTo(DateTime.now()) < 0 ||
                        widget.event!.isEnded == true
                    ? Colors.red
                    : Colors.green,
                size: 30,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        widget.event!.endDate!.compareTo(DateTime.now()) < 0
                            ? "منتهي"
                            : "مستمر",
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        widget.event!.endDate!.toString().substring(0, 19),
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: IconButton(
                  icon: const Icon(Icons.keyboard_arrow_down_rounded,
                      color: Colors.blue, size: 25),
                  onPressed: () {
                    setState(() {
                      showDetails = !showDetails;
                    });
                  }),
            ),
          ],
        ),
        TextSection(
          text: widget.event!.description,
          lines: showDetails == true ? null : 2,
        ),
        Divider(
          color: Colors.grey[400],
          thickness: 1,
        ),
      ],
    );
  }
}
