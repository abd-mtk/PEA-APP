import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../Models/event.dart';
import '../../Views/Screens/MapsScreens/show_event_screen.dart';
import '../../Views/Screens/UserScreens/display_user_profile_screen.dart';

class AllEventsController extends GetxController {
  final FirebaseFirestore eventsRef = FirebaseFirestore.instance;

  RxList<Event> events = <Event>[].obs;

  Future getEvents() async {
    events.clear();
    eventsRef.collection("events").snapshots().listen((event) {
      events.clear();
      for (var element in event.docs) {
        events.add(Event.fromJson(element.data()));
        // print(element.data());
      }
    });
  }

  void locationEvent(Event event) {
    Get.toNamed(ShowEventOnMapScreen.routeName, arguments: event);
  }

  void showUserProfile(String uid) {
    Get.toNamed(DisplayUserProfileScreen.routeName, arguments: uid);
  }

  @override
  void onInit() {
    events.clear();
    getEvents();
    super.onInit();
  }

  @override
  void onClose() {
    events.clear();
    super.onClose();
  }
}
