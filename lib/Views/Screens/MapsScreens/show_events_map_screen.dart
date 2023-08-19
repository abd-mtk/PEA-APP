import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pea/Views/Constants/fonts.dart';
import 'package:pea/Views/Constants/style.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../Controllers/ScreensControllers/show_events_map_controller.dart';
import '../../Widgets/filterd_button.dart';
import '../../Widgets/location_info.dart';
import '../../Widgets/text_section.dart';

// ignore: must_be_immutable
class ShowEventsOnMapScreen extends StatelessWidget {
  ShowEventsOnMapScreen({super.key});
  static const String routeName = '/showEventsOnMapScreen';

  ShowEventsOnMapController controller = Get.put(ShowEventsOnMapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('البحث المخصص'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            controller.showSetting = !controller.showSetting;
            controller.update();
          },
          icon: const Icon(Icons.search, color: Colors.white, size: 25),
        ),
        actions: [
          IconButton(
            onPressed: () {
              controller.changeMapMode();
            },
            icon: const Icon(Icons.settings, color: Colors.white, size: 25),
          ),
        ],
      ),
      body: GetBuilder<ShowEventsOnMapController>(builder: (_) {
        return Stack(children: [
          Positioned(
            top: 0,
            child: SizedBox(
              width: Get.width,
              height: Get.height * 0.8,
              child: GoogleMap(
                myLocationEnabled: true,
                indoorViewEnabled: true,
                mapType: controller.currentCameraMode,
                initialCameraPosition: controller.cameraPosition,
                onLongPress: controller.onLongMapTap,
                markers: controller.markers,
              ),
            ),
          ),
          controller.showSetting
              ? Positioned(
                  top: 55,
                  left: 35,
                  child: Container(
                    decoration: snowContainer,
                    height: Get.height * 0.35,
                    width: Get.width * 0.8,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "البحث عن الاحداث المحيطة",
                                style: buttonTextStylec,
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            "يمكنك البحث عن الاحداث المحيطة بك عبر تغيير نطاق البحث",
                            style: hintStyle,
                            textAlign: TextAlign.end,
                          ),
                        ),
                        SfSlider(
                          min: 0,
                          max: 100,
                          value: controller.searchDistance,
                          interval: 1,
                          onChanged: (dynamic newValue) {
                            controller.searchDistance = newValue;
                            controller.applyFilter();
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                              "  المسافة المحددة للبحث: ${controller.searchDistance.toInt()}  /كم"),
                        ),
                        const Gap(10),
                        FilteredButton(controller: controller)
                      ],
                    ),
                  ),
                )
              : Container(),
          controller.showEvents
              ? Positioned(
                  bottom: 5,
                  right: 10,
                  child: Container(
                    decoration: snowContainer,
                    height: Get.height * 0.65,
                    width: Get.width * 0.95,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 8.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        controller.showEvents =
                                            !controller.showEvents;
                                        controller.update();
                                      },
                                      icon: const Icon(Icons.close),
                                    ),
                                    const Text("معلومات الحدث",
                                        style: subtitleTextStyle),
                                  ])),
                          const Divider(
                            color: Colors.blueGrey,
                            thickness: 1,
                          ),
                          controller.isEvent
                              ? Column(
                                  children: [
                                    TextSection(
                                      text:
                                          "${controller.currentEvent.title} :العنوان",
                                    ),
                                    TextSection(
                                      text:
                                          "${controller.currentEvent.description} :الوصف",
                                    ),
                                    TextSection(
                                      text:
                                          "تاريخ النشر:  ${controller.currentEvent.startDate!}",
                                    ),
                                    TextSection(
                                      text:
                                          "تاريخ الانتهاء:  ${controller.currentEvent.endDate!}",
                                    ),
                                    Image.network(
                                      controller.currentEvent.image.toString(),
                                      fit: BoxFit.fill,
                                    ),
                                  ],
                                )
                              : Container(),
                          LocationInfo(
                            position: controller.currentLocation,
                            distance: controller.distance,
                            placemarks: controller.placemarks,
                          ),
                        ],
                      ),
                    ),
                  ))
              : Container(),
        ]);
      }),
    );
  }
}
