import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pea/Views/Widgets/event_widget.dart';

import '../../../Controllers/ScreensControllers/event_history_controller.dart';
import 'create_event_screen.dart';

// ignore: must_be_immutable
class EventsHistoryScreen extends StatelessWidget {
  EventsHistoryScreen({super.key});
  static const String routeName = '/eventsHistoryScreen';
  EventsHistoryController controller = Get.put(EventsHistoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تاريخ الاحداث الخاصة"),
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
                    return EventWidget(
                      event: controller.events[index],
                      onDeleted: () =>
                          controller.deleteEvent(controller.events[index]),
                      onEnable: () {
                        controller.enableEvent(controller.events[index]);
                      },
                      onEndevent: () {
                        controller.endEvent(controller.events[index]);
                      },
                      onLocation: () {
                        controller.Add24hours(controller.events[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(CreateEventsScreen.routeName);
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add_circle_rounded),
      ),
    );
  }
}
