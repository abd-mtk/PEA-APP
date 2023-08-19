import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../Controllers/ScreensControllers/auth_controller.dart';
import '../../Constants/colors.dart';
import '../../Widgets/input_field.dart';
import '../../Widgets/login_widget.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  static const String routeName = '/registerScreen';
  AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Logo(
              image: "assets/images/7.png",
            ),
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
            GetBuilder<AuthController>(builder: (_) {
              return InputField(
                textDirection: TextDirection.ltr,
                hintText: ' تأكيد كلمة المرور',
                defultValue: "",
                maxchar: 64,
                prefixicon: Icons.lock_clock_outlined,
                suffixicon: controller.showConfirmPassword
                    ? IconButton(
                        onPressed: () {
                          controller.toggleConfirmPassword();
                        },
                        icon: const Icon(
                          Icons.visibility_off,
                          size: 25,
                          color: primeColor,
                        ))
                    : IconButton(
                        onPressed: () {
                          controller.toggleConfirmPassword();
                        },
                        icon: const Icon(
                          Icons.visibility,
                          size: 25,
                          color: primeColor,
                        )),
                inputController: controller.confirmPasswordController,
                showPassword: controller.showConfirmPassword,
              );
            }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    controller.register();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'انشاء حساب',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
