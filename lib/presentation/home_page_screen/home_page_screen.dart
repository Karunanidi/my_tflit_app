import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_tflit_app/core/utils/appcolors.dart';
import 'package:my_tflit_app/core/utils/preferences_utils.dart';
import 'package:my_tflit_app/presentation/detector_screen/intro_screen.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  String score = '';

  @override
  void initState() {
    super.initState();
    _loadScore();
  }

  Future<void> _loadScore() async {
    score = await PreferenceUtils.getString(PreferenceUtils.userScore, '');
    log(score);
    if (score.isNotEmpty) {
      await PreferenceUtils.setString(PreferenceUtils.userScore, score);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
        leading: const SizedBox(),
        backgroundColor: AppColors.primary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('welcome Hunter'),
            const SizedBox(height: 14.0),
            ElevatedButton(
              onPressed: () {
                Get.to(() => const IntroScreen());
              },
              child: const Text('Start'),
            ),
            const SizedBox(height: 14.0),
            Text('current score : $score'),
          ],
        ),
      ),
    );
  }
}
