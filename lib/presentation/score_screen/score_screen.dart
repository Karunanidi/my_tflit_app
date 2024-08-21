import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_tflit_app/core/utils/preferences_utils.dart';
import 'package:my_tflit_app/presentation/home_page_screen/home_page_screen.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key, required this.isCorrect});
  final bool isCorrect;

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  final ValueNotifier<int> scoreNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _updateScore();
  }

  Future<void> _updateScore() async {
    // Retrieve the existing score if it exists, and parse it to an integer.
    String existingScoreString = await PreferenceUtils.getString(PreferenceUtils.userScore, '0');
    int existingScore = int.tryParse(existingScoreString) ?? 0;

    // Update the score based on the correctness of the answer
    int newScore = widget.isCorrect ? existingScore + 10 : existingScore;

    // Save the updated score as a string in preferences
    await PreferenceUtils.setString(PreferenceUtils.userScore, newScore.toString());
    log(newScore.toString());

    // Update the ValueNotifier with the new score
    scoreNotifier.value = newScore;
  }

  @override
  void dispose() {
    scoreNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const HomePageScreen());
      },
      child: Scaffold(
        body: Center(
          child: ValueListenableBuilder<int>(
            valueListenable: scoreNotifier,
            builder: (context, score, child) {
              return Text('Your score: $score');
            },
          ),
        ),
      ),
    );
  }
}
