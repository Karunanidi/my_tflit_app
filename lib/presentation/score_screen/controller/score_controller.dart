import 'package:get/get.dart';
import 'package:my_tflit_app/core/utils/preferences_utils.dart';
import 'dart:developer';

class ScoreController extends GetxController {
  var score = 0.obs;

  void updateScore(bool isCorrect) async {
    String existingScoreString = await PreferenceUtils.getString(PreferenceUtils.userScore, '0');
    int existingScore = int.tryParse(existingScoreString) ?? 0;

    int newScore = isCorrect ? existingScore + 10 : existingScore;

    await PreferenceUtils.setString(PreferenceUtils.userScore, newScore.toString());
    log(newScore.toString());

    score.value = newScore;
  }

  @override
  void onInit() {
    super.onInit();
    loadInitialScore();
  }

  Future<void> loadInitialScore() async {
    String existingScoreString = await PreferenceUtils.getString(PreferenceUtils.userScore, '0');
    int existingScore = int.tryParse(existingScoreString) ?? 0;
    score.value = existingScore;
  }
}
