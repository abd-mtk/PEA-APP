import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Controllers/ScreensControllers/user_setting_controller.dart';
import 'Middlewares/auth_middleware.dart';
import 'Views/Screens/MapsScreens/get_location_map_screen.dart';
import 'Views/Screens/MapsScreens/show_event_screen.dart';
import 'Views/Screens/UserScreens/display_user_profile_screen.dart';
import 'imports.dart';

SharedPreferences? prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PUBLIC EVENT APP',
      initialRoute: WelcomeScreen.routeName,
      debugShowCheckedModeBanner: false,
      getPages: [
        // App Screens
        GetPage(
          name: WelcomeScreen.routeName,
          page: () => const WelcomeScreen(),
          middlewares: [AuthMiddleware()],
        ),
        GetPage(
          name: LoginScreen.routeName,
          page: () => LoginScreen(),
        ),
        GetPage(
          name: RegisterScreen.routeName,
          page: () => RegisterScreen(),
        ),
        GetPage(
          name: HomeScreen.routeName,
          page: () => HomeScreen(),
        ),
        // Event Screens
        GetPage(
          name: AllEventsScreen.routeName,
          page: () => AllEventsScreen(),
        ),
        GetPage(
          name: CreateEventsScreen.routeName,
          page: () => CreateEventsScreen(),
        ),
        GetPage(
          name: EventsHistoryScreen.routeName,
          page: () => EventsHistoryScreen(),
        ),

        // Maps Screens
        GetPage(
          name: ShowEventsOnMapScreen.routeName,
          page: () => ShowEventsOnMapScreen(),
        ),
        GetPage(
          name: GetLocationScreen.routeName,
          page: () => GetLocationScreen(),
        ),
        // Setting Screens
        GetPage(
          name: AppSettingsScreen.routeName,
          page: () => const AppSettingsScreen(),
        ),
        GetPage(
            name: UserSettingsScreen.routeName,
            page: () => UserSettingsScreen(),
            bindings: <Bindings>[
              BindingsBuilder(
                () => Get.put(
                  UserSettingsController(),
                ),
              ),
            ]),
        // User Screens
        GetPage(
            name: UserProfileScreen.routeName,
            page: () => UserProfileScreen(),
            bindings: <Bindings>[
              BindingsBuilder(
                () => Get.put(
                  UserSettingsController(),
                ),
              ),
            ]),
        GetPage(
          name: DisplayUserProfileScreen.routeName,
          page: () => DisplayUserProfileScreen(),
        ),
        GetPage(
          name: ShowEventOnMapScreen.routeName,
          page: () => ShowEventOnMapScreen(),
        ),
      ],
    );
  }
}
