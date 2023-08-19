import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../imports.dart';

class HomeController extends GetxController {
  final _currentPage = 0.obs;

  int get currentPage => _currentPage.value;

  List<Widget> pages = [
     AllEventsScreen(),
    ShowEventsOnMapScreen(),
     EventsHistoryScreen(),
    UserProfileScreen(),
  ];

  void changePage(int index) {
    _currentPage.value = index;
    update();
  }
}
