import 'dart:developer';

import 'package:get/get.dart';

import '../../../core/utils/preferences_utils.dart';

class ScoreController extends GetxController {
  var score = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadScore();
  }

  Future<void> _loadScore() async {
    String fetchedScore =
        await PreferenceUtils.getString(PreferenceUtils.userScore, '');
    log(fetchedScore);

    if (fetchedScore.isNotEmpty) {
      await PreferenceUtils.setString(PreferenceUtils.userScore, fetchedScore);
    }

    score.value = fetchedScore;
  }

  void updateScore(String newScore) async {
    await PreferenceUtils.setString(PreferenceUtils.userScore, newScore);
    score.value = newScore;
  }
}
