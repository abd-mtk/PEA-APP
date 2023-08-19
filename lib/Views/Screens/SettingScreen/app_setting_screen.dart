import 'package:flutter/material.dart';

class AppSettingsScreen extends StatelessWidget {
  const AppSettingsScreen({super.key});
  static const String routeName = '/appSettingsScreen';
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("App Settings Screen"),
      ),
      body: const Center(
        child: Text("App Settings Screen"),
      ),
    );
  }
}