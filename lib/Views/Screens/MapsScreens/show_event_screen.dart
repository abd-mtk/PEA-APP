import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../Controllers/utilities/get_location.dart';
import '../../../Controllers/utilities/place_mark.dart';
import '../../../Models/event.dart';
import '../../Constants/fonts.dart';
import '../../Constants/style.dart';
import '../../Widgets/location_info.dart';
import '../../Widgets/text_section.dart';

// ignore: must_be_immutable
class ShowEventOnMapScreen extends StatefulWidget {
  const ShowEventOnMapScreen({super.key});
  static const String routeName = '/showEventOnMapScreen';

  @override
  State<ShowEventOnMapScreen> createState() => _ShowEventOnMapScreenState();
}

class _ShowEventOnMapScreenState extends State<ShowEventOnMapScreen> {
  Event event = Get.arguments;
  bool showEvents = false;
  String distance = "0";
  late Position position;
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

  void distanceInfo() async {
    position = await determinePosition();
    distance = await distanceBetweenMyLocationAndMarker(event.location!);
  }

  final List<MapType> cameraMode = const [
    MapType.normal,
    MapType.satellite,
    MapType.terrain,
    MapType.hybrid,
  ];
  MapType currentCameraMode = MapType.normal;
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
    setState(() {});
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

  @override
  void initState() {
    distanceInfo();
    print(event.placemarks);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تحديد الموقع'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                changeMapMode();
              });
            },
            icon: const Icon(Icons.settings, color: Colors.white, size: 25),
          ),
        ],
      ),
      body: Stack(children: [
        Positioned(
          top: 0,
          child: SizedBox(
            width: Get.width,
            height: Get.height * 0.89,
            child: GoogleMap(
              myLocationEnabled: true,
              indoorViewEnabled: true,
              mapType: currentCameraMode,
              initialCameraPosition: CameraPosition(
                target: LatLng(event.location![0], event.location![1]),
                zoom: 15,
              ),
              markers: {
                Marker(
                  markerId: MarkerId(event.id.toString()),
                  position: LatLng(event.location![0], event.location![1]),
                  infoWindow: InfoWindow(
                    title: event.title,
                    snippet: event.description,
                  ),
                  onTap: () {
                    setState(() {
                      showEvents = true;
                    });
                  },
                ),
              },
            ),
          ),
        ),
        showEvents
            ? Positioned(
                bottom: 5,
                right: 10,
                child: Container(
                  decoration: snowContainer,
                  height: Get.height * 0.65,
                  width: Get.width * 0.95,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 8.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        showEvents = false;
                                      });
                                    },
                                    icon: const Icon(Icons.close),
                                  ),
                                  const Text("معلومات الحدث",
                                      style: subtitleTextStyle),
                                ])),
                        const Divider(
                          color: Colors.blueGrey,
                          thickness: 1,
                        ),
                        Column(
                          children: [
                            TextSection(
                              text: "${event.title} :العنوان",
                            ),
                            TextSection(
                              text: "${event.description} :الوصف",
                            ),
                            TextSection(
                              text: "تاريخ النشر:  ${event.startDate!}",
                            ),
                            TextSection(
                              text: "تاريخ الانتهاء:  ${event.endDate!}",
                            ),
                            Image.network(
                              event.image.toString(),
                              fit: BoxFit.fill,
                            ),
                            LocationInfo(
                              position: LatLng(
                                  event.location![0], event.location![1]),
                              distance: distance,
                            ),
                            TextSection(text: placeMarkevent(event.placemarks))
                          ],
                        ),
                      ],
                    ),
                  ),
                ))
            : Container(),
      ]),
    );
  }
}
