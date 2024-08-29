import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_tflit_app/core/utils/appcolors.dart';
import 'package:my_tflit_app/presentation/detector_screen/detector_screen.dart';
import 'package:my_tflit_app/presentation/detector_screen/hunt_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () => Get.to(() => const HuntScreen()),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Let's Hunt!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                ),
                Text('the machine is preparing for you..'),
              ],
            ),
            SizedBox(height: 20.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(child: CircularProgressIndicator()),
                SizedBox(height: 36.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
