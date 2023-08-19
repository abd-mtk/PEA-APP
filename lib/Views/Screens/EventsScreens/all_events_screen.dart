import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/ScreensControllers/all_event_controller.dart';
import '../../Widgets/home_widget.dart';

// ignore: must_be_immutable
class AllEventsScreen extends StatelessWidget {
  AllEventsScreen({super.key});
  static const String routeName = '/allEventsScreen';
  AllEventsController controller = Get.put(AllEventsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الاحداث العامة"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () => ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.events.length,
                  itemBuilder: (context, index) {
                    return HomeWidget(
                      event: controller.events[index],
                      onShowProfile: () {
                        controller.showUserProfile(
                            controller.events[index].userId.toString());
                      },
                      onLocation: () {
                        controller.locationEvent(controller.events[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
