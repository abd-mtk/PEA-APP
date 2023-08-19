import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddEventInformation {
  String? id;
  String? userId;
  String title;
  String description;
  String image;
  DateTime startDate;
  DateTime? endDate;
  bool isEnded = false;
  LatLng? location;
  List<Placemark>? placemarks;

  AddEventInformation({
    this.id,
    this.userId,
    required this.title,
    required this.description,
    required this.image,
    required this.startDate,
    required this.endDate,
    this.isEnded = false,
    required this.location,
    required this.placemarks,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'image': image,
      'startDate': startDate,
      // if endDate is null, set it to startDate value + 1 day
      'endDate': endDate ?? startDate.add(const Duration(days: 1)),
      'isEnded': isEnded,
      'location': location != null ? location!.toJson() : null,
      'placemarks': placemarks != null ? placemarks!.first.toJson() : null,
    };
  }

  factory AddEventInformation.fromJson(Map<String, dynamic> json) {
    return AddEventInformation(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      isEnded: json['isEnded'],
      location: json['location'],
      placemarks: json['placemarks'],
    );
  }
}
