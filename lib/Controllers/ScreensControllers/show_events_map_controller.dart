import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pea/Models/event.dart';

import '../../Views/Constants/fonts.dart';
import '../utilities/get_location.dart';

class ShowEventsOnMapController extends GetxController {
  final FirebaseFirestore eventsRef = FirebaseFirestore.instance;

  

  List<List<double>> eventsList = <List<double>>[];
  Event currentEvent = Event();

  final Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(33.314815005455586, 44.366285875439644),
    zoom: 9,
  );
  bool showEvents = false;
  late Position position;
  LatLng currentLocation = const LatLng(33.314815005455586, 44.366285875439644);
  final Set<Marker> _markers = {};
  Set<Marker> get markers => _markers;
  MapType currentCameraMode = MapType.normal;
  List<Placemark>? placemarks;
  String distance = "0";

  final List<MapType> cameraMode = const [
    MapType.normal,
    MapType.satellite,
    MapType.terrain,
    MapType.hybrid,
  ];

  bool showSetting = false;
  double searchDistance = 0;
  bool isEvent = false;

  @override
  void onInit() async {
    position = await determinePosition();
    currentLocation = LatLng(position.latitude, position.longitude);
    super.onInit();
  }

  Future<Event> getEvents(LatLng location) async {
    Event event_ = Event();
    await eventsRef
        .collection("events")
        .where("location", isEqualTo: location.toJson())
        .get()
        .then((event) {
      if (event.docs.isNotEmpty) {
        event_ = Event.fromJson(event.docs.first.data());
        currentEvent = event_;
      }
    });
    return event_;
  }

  void getEventsFilterd() async {
    eventsRef.collection("events").get().then((event) {
      eventsList.clear();
      for (var element in event.docs) {
        if (element.data()["location"] != null) {
          List<double> eventLocation =
              element.data()["location"].cast<double>();
          distanceBetweenMyLocationAndMarker(eventLocation).then((value) {
            if (double.parse(value) <= searchDistance) {
              eventsList.add(eventLocation);
            }
          });
        }
      }
    });
  }

  void applyFilter() {
    markers.clear();
    getEventsFilterd();
    for (var i = 0; i < eventsList.length; i++) {
      onLongMapTap(LatLng(eventsList[i][0], eventsList[i][1]));
    }
    update();
  }

  void clearFilter() {
    markers.clear();
    update();
  }

  // distance between my location and marker
  Future<String> distanceBetweenMyLocationAndMarker(
      List<double> eventLocation) async {
    double distanceInMeters = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      eventLocation[0],
      eventLocation[1],
    );
    return (distanceInMeters / 1000).toStringAsFixed(2);
  }

  void updatePlaceMark(position) async {
    await getEvents(position).then((value) => {
          if (value.location != null) {isEvent = true} else {isEvent = false}
        });
    placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    update();
  }

  

  void onLongMapTap(LatLng position) async {
    updatePlaceMark(position);
    markers.add(Marker(
      position: position,
      markerId: MarkerId(position.toString()),
      infoWindow: InfoWindow(
          title: placemarks![0].country.toString(),
          snippet: placemarks![0].subAdministrativeArea.toString(),
          onTap: () {
            updatePlaceMark(position);
            distanceBetweenMyLocationAndMarker(
                <double>[position.latitude, position.longitude]).then((value) {
              distance = value;
              showEvents = !showEvents;
              update();
            });
          }),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
    ));
    update();
  }





  void getMyLocation() async {
    final GoogleMapController moveController = await googleMapController.future;
    currentLocation = LatLng(position.latitude, position.longitude);
    cameraPosition = CameraPosition(
      target: currentLocation,
      zoom: 19,
    );
    onLongMapTap(currentLocation);
    moveController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    update();
  }

  void changeCameraMode(String mode) {
    switch (mode) {
      case 'normal':
        currentCameraMode = MapType.normal;
        break;
      case 'satellite':
        currentCameraMode = MapType.satellite;
        break;
      case 'terrain':
        currentCameraMode = MapType.terrain;
        break;
      case 'hybrid':
        currentCameraMode = MapType.hybrid;
        break;
    }
    update();
  }

  void changeMapMode() {
    Get.defaultDialog(
      title: "تغيير نوع الخريطة",
      content: Column(
        children: [
          ListTile(
            trailing: currentCameraMode == MapType.normal
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            title: const Text('عادي', style: subtitleTextStyle),
            onTap: () {
              changeCameraMode('normal');
              Get.back();
            },
          ),
          ListTile(
            trailing: currentCameraMode == MapType.satellite
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            title: const Text('قمر صناعي', style: subtitleTextStyle),
            onTap: () {
              changeCameraMode('satellite');
              Get.back();
            },
          ),
          ListTile(
            trailing: currentCameraMode == MapType.terrain
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            title: const Text('تضاريس', style: subtitleTextStyle),
            onTap: () {
              changeCameraMode('terrain');
              Get.back();
            },
          ),
          ListTile(
            trailing: currentCameraMode == MapType.hybrid
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            title: const Text('هجين', style: subtitleTextStyle),
            onTap: () {
              changeCameraMode('hybrid');
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
