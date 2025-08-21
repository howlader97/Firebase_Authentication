import 'package:firebase_ahthentication_app/controller/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final AuthenticationController controller=Get.put(AuthenticationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: FlutterLogo(size: 100)));
  }
}
