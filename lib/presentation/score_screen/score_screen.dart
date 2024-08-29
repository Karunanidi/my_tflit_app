import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_tflit_app/presentation/home_page_screen/home_page_screen.dart';
import 'package:my_tflit_app/presentation/score_screen/controller/score_controller.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key, required this.isCorrect});
  final bool isCorrect;

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  final ScoreController controller = Get.put(ScoreController());

  @override
  void initState() {
    controller.updateScore(widget.isCorrect);
    super.initState();
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
              return Text('Your score: ${controller.score.value}');
            }),
          ),
        ),
      ),
    );
  }
}
