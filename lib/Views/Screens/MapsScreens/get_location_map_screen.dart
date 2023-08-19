import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pea/Views/Constants/style.dart';

import '../../../Controllers/ScreensControllers/get_location_contrller.dart';
import '../../Constants/button_style.dart';
import '../../Constants/fonts.dart';
import '../../Widgets/location_info.dart';

// ignore: must_be_immutable
class GetLocationScreen extends StatelessWidget {
  GetLocationScreen({super.key});

  static const String routeName = '/getLocationScreen';
  GetLocationController controller = Get.put(GetLocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تحديد الموقع'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              controller.changeMapMode();
            },
            icon: const Icon(Icons.settings, color: Colors.white, size: 30),
          ),
        ],
      ),
      body: GetBuilder<GetLocationController>(builder: (_) {
        return Column(
          children: [
            Container(
              decoration: snowContainer,
              height: Get.height * 0.5,
              child: GoogleMap(
                myLocationEnabled: true,
                indoorViewEnabled: true,
                circles: controller.circles,
                mapType: controller.currentCameraMode,
                initialCameraPosition: controller.cameraPosition,
                onMapCreated: controller.onMapCreated,
                onLongPress: controller.onLongMapTap,
                markers: controller.markers,
              ),
            ),
            const Gap(5),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SnowButton(
                    text: const Text('تحديد موقعي', style: buttonTextStylec),
                    icon: const Icon(Icons.location_on_rounded,
                        color: Colors.redAccent),
                    decoration: snowContainer,
                    height: 40,
                    color: Colors.white,
                    onPressed: () {
                      controller.getMyLocation();
                    },
                  ),
                  SnowButton(
                    text: const Text(
                      'تأكيد الموقع',
                      style: buttonTextStylec,
                    ),
                    icon: const Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    decoration: snowContainer,
                    height: 40,
                    color: Colors.white,
                    onPressed: () {
                      controller.confirmationLocation();
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SnowButton(
                  text: const Text(
                    'حذف العلامة',
                    style: buttonTextStylec,
                  ),
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.redAccent,
                  ),
                  decoration: snowContainer,
                  height: 40,
                  color: Colors.white,
                  onPressed: () {
                    controller.deleteMarker(
                        MarkerId(controller.currentLocation.toString()));
                  },
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    LocationInfo(
                      position: controller.currentLocation,
                      distance: controller.distance,
                      placemarks: controller.placemarks,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
