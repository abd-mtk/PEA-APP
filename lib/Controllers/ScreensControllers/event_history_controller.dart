import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Models/event.dart';

class EventsHistoryController extends GetxController {
  final FirebaseFirestore eventsRef = FirebaseFirestore.instance;
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  RxList<Event> events = <Event>[].obs;

  Future getEvents() async {
    eventsRef
        .collection("users")
        .doc(uid)
        .collection("events")
        .snapshots()
        .listen((event) {
      events.clear();
      for (var element in event.docs) {
        Event event = Event.fromJson(element.data());
        event.id = element.id;
        events.add(event);
      }
    });
  }

  void enableEvent(Event event) async {
    // make event enabled by changing isEnded to false and endDate to current date and endDate to is current date + 24 hours
    eventsRef
        .collection("users")
        .doc(uid)
        .collection("events")
        .doc(event.id)
        .update({
      "isEnded": false,
      "endDate": DateTime.now().add(const Duration(hours: 24)),
      "startDate": DateTime.now(),
    }).then((value) => {
              eventsRef
                  .collection("events")
                  .where("id", isEqualTo: event.id)
                  .get()
                  .then((value) => value.docs.first.reference.update({
                        "isEnded": false,
                        "endDate":
                            DateTime.now().add(const Duration(hours: 24)),
                        "startDate": DateTime.now(),
                      }))
            });
    Get.snackbar("اعادة التفعيل", "تم اعادة التفعيل بنجاح",
        snackPosition: SnackPosition.TOP, backgroundColor: Colors.green);
  }

  void deleteEvent(Event event) async {
    eventsRef
        .collection("users")
        .doc(uid)
        .collection("events")
        .doc(event.id)
        .delete()
        .then((value) => {
              eventsRef
                  .collection("events")
                  .where("id", isEqualTo: event.id)
                  .get()
                  .then((value) => value.docs.first.reference.delete())
            });
    Get.snackbar("حذف الحدث", "تم حذف الحدث بنجاح",
        snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
    getEvents();
  }

  void endEvent(Event event) async {
    eventsRef
        .collection("users")
        .doc(uid)
        .collection("events")
        .doc(event.id)
        .update({"isEnded": true}).then((value) => {
              eventsRef
                  .collection("events")
                  .where("id", isEqualTo: event.id)
                  .get()
                  .then((value) =>
                      value.docs.first.reference.update({"isEnded": true}))
            });
    Get.snackbar("انتهاء الحدث", "تم انتهاء الحدث بنجاح",
        snackPosition: SnackPosition.TOP, backgroundColor: Colors.teal);
    getEvents();
  }

  void Add24hours(Event event) {
    eventsRef
        .collection("users")
        .doc(uid)
        .collection("events")
        .doc(event.id)
        .update({
      "endDate": event.endDate!.add(const Duration(hours: 24))
    }).then((value) => {
              eventsRef
                  .collection("events")
                  .where("id", isEqualTo: event.id)
                  .get()
                  .then((value) => value.docs.first.reference.update({
                        "endDate": event.endDate!.add(const Duration(hours: 24))
                      }))
            });
    Get.snackbar("اضافة 24 ساعة", "تم اضافة 24 ساعة بنجاح",
        snackPosition: SnackPosition.TOP, backgroundColor: Colors.teal);
    getEvents();
  }

  @override
  void onInit() {
    getEvents();
    super.onInit();
  }
}
