import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../utilities/add_event_information.dart';
import '../utilities/get_location.dart';
import '../utilities/snak_bar.dart';

class CreateEventController extends GetxController {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final descriptionController = TextEditingController();
  final titleController = TextEditingController();
  List<Placemark> placemarks = [];
  DateTime startDate = DateTime.now();
  DateTime? endDate;
  LatLng? location;
  List<Placemark>? placemarksList;
  File? image;
  String imageUrl = '';

  Future<void> addEvent(info) async {
    if (info == null) {
      await myLocation(false);
    }
    if (image != null) {
      try {
        imageUrl = await uploadImage();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('events')
            .add(AddEventInformation(
              title: titleController.text,
              description: descriptionController.text,
              image: imageUrl,
              startDate: startDate,
              endDate: endDate,
              location: info != null ? info[0] ?? location : location,
              placemarks: info != null ? info[1] ?? placemarks : placemarks,
            ).toJson())
            .then((value) => {
                  FirebaseFirestore.instance
                      .collection('events')
                      .add(AddEventInformation(
                        id: value.id,
                        userId: uid,
                        title: titleController.text,
                        description: descriptionController.text,
                        image: imageUrl,
                        startDate: startDate,
                        endDate: endDate,
                        location: info != null ? info[0] ?? location : location,
                        placemarks:
                            info != null ? info[1] ?? placemarks : placemarks,
                      ).toJson())
                      .whenComplete(() => {
                            clear(),
                            SnakBar.successSnakBar('تم', 'تم إضافة الحدث بنجاح')
                          })
                });
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        await FirebaseStorage.instance.refFromURL(imageUrl).delete().then(
            (_) => {SnakBar.errorSnakBar('خطأ', 'حدث خطأ أثناء إضافة الحدث')});
      }
    } else {
      SnakBar.warningSnakBar('خطأ', 'يجب إضافة صورة');
    }
  }

  // upload image to firebase storage
  Future<String> uploadImage() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference =
        FirebaseStorage.instance.ref().child('events/$fileName');
    UploadTask uploadTask = reference.putFile(image!);
    TaskSnapshot taskSnapshot = await uploadTask;
    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    return imageUrl;
  }

  Future getImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      update();
    } else {
      SnakBar.warningSnakBar('انتبه', 'لم يتم اختيار صورة');
    }
  }

  Future getImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      update();
    } else {
      SnakBar.warningSnakBar('انتبه', 'لم يتم اختيار صورة');
    }
  }

  timePicker() async {
    DateTime? dateTime = await showOmniDateTimePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      lastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      is24HourMode: false,
      isShowSeconds: false,
      minutesInterval: 1,
      secondsInterval: 1,
      isForce2Digits: true,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      constraints: const BoxConstraints(
        maxWidth: 350,
        maxHeight: 650,
      ),
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
    );
    if (dateTime != null) {
      endDate = dateTime;
      update();
    }
  }

  Future myLocation(bool showsnak) async {
    await determinePosition()
        .then((value) => {location = LatLng(value.latitude, value.longitude)});
    await placemarkFromCoordinates(location!.latitude, location!.longitude)
        .then((value) => {placemarks = value});
    update();
    if (showsnak) {
      SnakBar.successSnakBar('تم', 'تم تحديد موقعك بنجاح');
    }
  }

  void clear() {
    titleController.clear();
    descriptionController.clear();
    startDate = DateTime.now();
    endDate = null;
    location = null;
    placemarks = [];
    image = null;
    update();
    Get.back();
  }
}
