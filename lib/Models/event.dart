import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String? id;
  String? userId;
  String? title;
  String? description;
  List<double>? location;
  dynamic placemarks;
  DateTime? startDate;
  DateTime? endDate;
  bool? isEnded = false;
  String? image;
  
  



  Event({
    this.id,
    this.userId,
    this.title,
    this.description,
    this.location,
    this.placemarks,
    this.startDate,
    this.endDate,
    this.isEnded = false,
    this.image,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      description: json['description'],
      location: json['location'] != null
          ? json['location'].cast<double>()
          : <double>[],
      placemarks: json['placemarks'],
      startDate: json['startDate'] != null
          ? (json['startDate'] as Timestamp).toDate()
          : null,
      endDate: json['endDate'] != null
          ? (json['endDate'] as Timestamp).toDate()
          : null,
      isEnded: json['isEnded'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'location': location,
      'placemarks': placemarks,
      'startDate': startDate,
      'endDate': endDate,
      'isEnded': isEnded,
      'image': image
    };
  }
}
