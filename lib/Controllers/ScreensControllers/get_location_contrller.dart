import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pea/imports.dart';

import '../../Views/Constants/fonts.dart';
import '../utilities/get_location.dart';

class GetLocationController extends GetxController {
  Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();

  LatLng currentLocation = const LatLng(0, 0);
  MapType currentCameraMode = MapType.normal;
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(33.314815005455586, 44.366285875439644),
    zoom: 14,
  );
  List<MapType> cameraMode = [
    MapType.normal,
    MapType.satellite,
    MapType.terrain,
    MapType.hybrid,
  ];

  final Set<Marker> _markers = {};
  final Set<Circle> circles = {};

  Set<Marker> get markers => _markers;
  String distance = "0";

  List<Placemark>? placemarks;

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

  void onMapCreated(GoogleMapController controller) {
    googleMapController.complete(controller);
  }

  void onCameraMove(CameraPosition position) {
    currentLocation = position.target;
    cameraPosition = position;
    update();
  }

  void onCameraIdle() {
    update();
  }

  void onLongMapTap(LatLng position) async {
    _markers.add(Marker(
        position: position,
        markerId: MarkerId(position.toString()),
        infoWindow: const InfoWindow(
          title: "موقع الحدث",
        ),
        icon: BitmapDescriptor.defaultMarker,
        onTap: () async {
          currentLocation = position;
          placemarks = await placemarkFromCoordinates(
              currentLocation.latitude, currentLocation.longitude);
          distance = await distanceBetweenMyLocationAndMarker();
          update();
        }));
    currentLocation = position;
    placemarks = await placemarkFromCoordinates(
        currentLocation.latitude, currentLocation.longitude);
    distance = await distanceBetweenMyLocationAndMarker();
    addCircle();
    update();
  }

  // delete marker
  void deleteMarker(MarkerId markerId) async {
    circles.clear();
    _markers.removeWhere((marker) => marker.markerId == markerId);
    currentLocation = const LatLng(0, 0);
    distance = "0";
    placemarks = null;
    update();
  }

  void getMyLocation() async {
    final GoogleMapController moveController = await googleMapController.future;
    Position position = await determinePosition();
    currentLocation = LatLng(position.latitude, position.longitude);
    cameraPosition = CameraPosition(
      target: currentLocation,
      zoom: 19,
    );
    onLongMapTap(currentLocation);
    addCircle();
    moveController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    update();
  }

  void addCircle() {
    circles.add(Circle(
      circleId: const CircleId('1'),
      center: currentLocation,
      radius: 50,
      fillColor: Colors.blue.withOpacity(0.2),
      strokeColor: Colors.blue,
      strokeWidth: 2,
    ));

    update();
  }

  // distance between my location and marker
  Future<String> distanceBetweenMyLocationAndMarker() async {
    Position position = await determinePosition();
    double distanceInMeters = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      currentLocation.latitude,
      currentLocation.longitude,
    );
    return (distanceInMeters / 1000).toStringAsFixed(2);
  }

  void confirmationLocation() {
    Get.defaultDialog(
        title: "سيتم اختيار الموقع المحدد",
        middleText: "بعدك عن الحدث الحالي هو $distance",
        buttonColor: Colors.blueAccent,
        textConfirm: "موافق",
        confirmTextColor: Colors.white,
        onConfirm: () => {
              Get.offAndToNamed(CreateEventsScreen.routeName,
                  arguments: [currentLocation, placemarks]),
            });
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
