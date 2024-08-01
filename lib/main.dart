import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_tflit_app/controller/image_controller.dart';
import 'package:my_tflit_app/detector_screen.dart';

void main() {
  Get.put(ImageController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: DetectorScreen(),
    );
  }
}
