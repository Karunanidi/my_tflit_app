import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_tflit_app/core/utils/appcolors.dart';
import 'package:my_tflit_app/core/utils/preferences_utils.dart';
import 'package:my_tflit_app/presentation/detector_screen/controller/image_controller.dart';
import 'package:my_tflit_app/presentation/onboardning_screen/onboarding_screen.dart';
import 'package:my_tflit_app/presentation/score_screen/controller/score_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await PreferenceUtils.init();
  DartPluginRegistrant.ensureInitialized();
  Get.put(ImageController());
  Get.put(ScoreController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blue),
        useMaterial3: true,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: const OnboardingScreen(),
    );
  }
}



