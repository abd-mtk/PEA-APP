import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pea/main.dart';

import '../imports.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  // ignore: overridden_fields
  int? priority = 1;

  @override
  redirect(String? route) {
    if (prefs!.getString("uid") != null) {
      return const RouteSettings(name: HomeScreen.routeName);
    } else {
      return null;
    }
  }
}
