import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../Controllers/ScreensControllers/home_controller.dart';
import '../../Constants/colors.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  static const String routeName = '/homeScreen';

  HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(
        builder: (_) {
          return controller.pages[controller.currentPage];
        },
      ),
      bottomNavigationBar: GNav(
          selectedIndex: controller.currentPage,
          onTabChange: (index) {
            controller.changePage(index);
          },
          tabBorderRadius: 25,
          curve: Curves.easeInToLinear,
          activeColor: Colors.white,
          iconSize: 25,
          tabBackgroundColor: primeColor,
          padding: const EdgeInsets.all(12),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'الرئيسية',
            ),
            GButton(
              icon: Icons.map,
              text: 'الخريطة',
            ),
            GButton(
              icon: Icons.category,
              text: 'احداثي',
            ),
            GButton(
              icon: Icons.person,
              text: 'الملف الشخصي',
            )
          ]),
    );
  }
}
