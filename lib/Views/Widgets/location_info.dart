import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Controllers/utilities/place_mark.dart';
import 'text_section.dart';
// import 'package:geolocator/geolocator.dart';

// ignore: must_be_immutable
class LocationInfo extends StatelessWidget {
  LatLng position;
  String? distance = "0";
  List<Placemark>? placemarks;
  LocationInfo(
      {Key? key, required this.position, this.distance, this.placemarks})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextSection(text: "بعدي عن موقع الحدث : $distance كم"),
        const Gap(3),
        TextSection(text: "خط العرض: ${position.latitude}"),
        const Gap(3),
        TextSection(text: "خط الطول: ${position.longitude}"),
        const Gap(3),
        placemarks != null
            ? TextSection(text: placeMark(placemarks![0]))
            : const Gap(0),
      ],
    );
  }
}
