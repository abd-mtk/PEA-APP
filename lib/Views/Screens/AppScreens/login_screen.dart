import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../Controllers/ScreensControllers/auth_controller.dart';
import '../../Constants/colors.dart';
import '../../Constants/fonts.dart';
import '../../Widgets/input_field.dart';
import '../../Widgets/login_widget.dart';
import 'register_screen.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  static const routeName = '/loginScreen';

  AuthController controller = Get.put(AuthController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Logo(image: "assets/images/6.png",),
            const Gap(50),
            GetBuilder<AuthController>(builder: (_) {
              return InputField(
                defultValue: "",
                hintText: 'البريد الالكتروني',
                prefixicon: Icons.email,
                suffixicon: null,
                inputController: controller.emailController,
                showPassword: false,
                maxchar: 64,
              );
            }),
            GetBuilder<AuthController>(builder: (_) {
              return InputField(
                defultValue: "",
                hintText: 'كلمة المرور',
                maxchar: 64,
                prefixicon: Icons.lock,
                suffixicon: controller.showPassword
                    ? IconButton(
                        onPressed: () {
                          controller.togglePassword();
                        },
                        icon: const Icon(
                          Icons.visibility_off,
                          size: 25,
                          color: primeColor,
                        ))
                    : IconButton(
                        onPressed: () {
                          controller.togglePassword();
                        },
                        icon: const Icon(
                          Icons.visibility,
                          size: 25,
                          color: primeColor,
                        )),
                inputController: controller.passwordController,
                showPassword: controller.showPassword,
              );
            }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    controller.login();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text('تسجيل الدخول', style: buttonTextStyle),
                ),
              ),
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Get.toNamed(RegisterScreen.routeName);
                  },
                  child: const Text(
                    'انشاء حساب ',
                    style: buttonTextStylec,
                  ),
                ),
                const Text(
                  'ليس لديك حساب؟',
                  style: generalTextStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
