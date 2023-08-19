import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../Constants/intro_style.dart';
import '../../Constants/introduction_list.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  static const String routeName = '/welcomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        bodyPadding: const EdgeInsets.all(10),
        dotsDecorator: dotstyle,
        curve: Curves.easeInCubic,
        globalBackgroundColor: Colors.white,
        pages: introductionList,
        showSkipButton: true,
        showNextButton: false,
        skip: const Text("تخطي", style: buttonstyle),
        done: const Text("اكمال", style: buttonstyle),
        onDone: () {
          Get.toNamed(LoginScreen.routeName);
        },
      ),
    );
  }
}
