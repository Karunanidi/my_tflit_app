import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_tflit_app/presentation/home_page_screen/home_page_screen.dart';
import 'package:my_tflit_app/presentation/score_screen/controller/score_controller.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  final ScoreController controller = Get.put(ScoreController());
  final Rx<Color> _textColor = Colors.black.obs;

  @override
  void initState() {
    super.initState();
    _showFlashingText();
  }

  void _showFlashingText() {
    _textColor.value = Colors.green;
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (timer.tick > 5) {
        timer.cancel();
        _textColor.value = Colors.black;
      } else {
        _textColor.value =
            _textColor.value == Colors.black ? (Colors.green) : Colors.black;
      }
    });

    Future.delayed(const Duration(seconds: 5), () {
      Get.to(() => const HomePageScreen());
    });
  }

  _onPop(didpop) {
    if (didpop) {
      return;
    }
    Get.offAll(() => const HomePageScreen());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didpop) {
        _onPop(didpop);
      },
      child: GestureDetector(
        onTap: () {
          Get.to(() => const HomePageScreen());
        },
        child: Scaffold(
          body: Center(
            child: Obx(() {
              return Text(
                'Your score: ${controller.score.value}',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: _textColor.value),
              );
            }),
          ),
        ),
      ),
    );
  }
}
