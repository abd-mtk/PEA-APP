import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/ScreensControllers/show_events_map_controller.dart';
import '../Constants/fonts.dart';
import '../Constants/style.dart';

class FilteredButton extends StatelessWidget {
  const FilteredButton({
    super.key,
    required this.controller,
  });

  final ShowEventsOnMapController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          child: Container(
            decoration: snowContainer,
            width: Get.width * 0.3,
            height: Get.height * 0.05,
            child: const Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.cancel_outlined, color: Colors.redAccent),
                Text(
                  "حذف الكل",
                  style: buttonTextStylec,
                ),
              ],
            )),
          ),
          onTap: () async {
            controller.clearFilter();
          },
        ),
        InkWell(
          child: Container(
            decoration: snowContainer,
            width: Get.width * 0.25,
            height: Get.height * 0.05,
            child: const Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.close_outlined, color: Colors.blueAccent),
                Text(
                  "اغلاق",
                  style: buttonTextStylec,
                ),
              ],
            )),
          ),
          onTap: () {
            controller.applyFilter();
            controller.showSetting = !controller.showSetting;
            controller.update();
          },
        ),
      ],
    );
  }
}
