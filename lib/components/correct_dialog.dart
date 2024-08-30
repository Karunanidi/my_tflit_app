import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:my_tflit_app/presentation/score_screen/score_screen.dart';

class CorrectDialog extends StatelessWidget {
  CorrectDialog({super.key, required this.isCorrect});
  bool isCorrect;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              isCorrect
                  ? 'assets/lottie_correct.json'
                  : 'assets/lottie_incorrect.json',
            ),
            Text(
              isCorrect ? 'correct!' : 'incorrect!',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isCorrect ? Colors.green : Colors.red),
            ),
            const SizedBox(height: 18.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.offAll(
                        () => const ScoreScreen(),
                      );
                    },
                    child: const Text('continue'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
