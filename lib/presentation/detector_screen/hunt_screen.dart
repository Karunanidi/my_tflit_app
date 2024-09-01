import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_tflit_app/components/custom_image_view.dart';
import 'package:my_tflit_app/core/utils/appcolors.dart';
import 'package:my_tflit_app/presentation/detector_screen/components/camera_screen.dart';
import 'package:my_tflit_app/presentation/detector_screen/components/object_dummy.dart';
import 'package:my_tflit_app/presentation/detector_screen/controller/image_controller.dart';
import 'package:my_tflit_app/presentation/score_screen/controller/score_controller.dart';
import 'package:my_tflit_app/presentation/score_screen/score_screen.dart';

class HuntScreen extends StatefulWidget {
  const HuntScreen({super.key});

  @override
  State<HuntScreen> createState() => _HuntScreenState();
}

class _HuntScreenState extends State<HuntScreen> {
  final imageController = ImageController.to;
  final scoreController = Get.find<ScoreController>();

  final RxString _randomFruit = ''.obs;
  final RxString _randomFruitEmoji = ''.obs;
  final RxString _randomDinoImg = ''.obs;

  final RxInt _itemsLeft = 6.obs;
  final RxInt _temporaryScore = 0.obs;
  final Rx<Color> _textColor = Colors.black.obs;
  final RxBool _isButtonEnabled = true.obs;

  void _generateRandomFruit() {
    final random = Random();
    final fruits =
        objectFruitsList[random.nextInt(objectFruitsList.length)];
    _randomFruit.value = fruits.object;
    _randomFruitEmoji.value = fruits.emoji;
    _randomDinoImg.value = fruits.imagePath;
    imageController.clearImage();
    _textColor.value = Colors.black;
    _itemsLeft.value--;
  }

  void _showFlashingText(bool isCorrect) {
    _isButtonEnabled.value = false;
    _textColor.value = isCorrect ? Colors.green : Colors.red;
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (timer.tick > 5) {
        timer.cancel();
        _textColor.value = Colors.black;
        _isButtonEnabled.value = true;
      } else {
        _textColor.value = _textColor.value == Colors.black
            ? (isCorrect ? Colors.green : Colors.red)
            : Colors.black;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _generateRandomFruit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Text(
                        'Items left: ${_itemsLeft.value}',
                        style: const TextStyle(fontSize: 16.0),
                      )),
                  Obx(() => Text(
                        '${_temporaryScore.value}/500',
                        style: const TextStyle(fontSize: 16.0),
                      )),
                ],
              ),

              // Main content area
              Column(
                children: [
                  const Text(
                    'Next item to find:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 14.0),
                  Obx(
                    () => _randomDinoImg.value == ''
                        ? const SizedBox()
                        : Container(
                            margin: const EdgeInsets.all(8.0),
                            height: 70,
                            width: 70,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: CustomImageView(
                                imagePath: _randomDinoImg.value,
                              ),
                            ),
                          ),
                  ),
                  Obx(() {
                    return Text(
                      '${_randomFruit.value} ${_randomFruitEmoji.value}',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: _textColor.value),
                    );
                  }),
                ],
              ),

              // Bottom buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _generateRandomFruit();

                        if (_itemsLeft.value <= 0) {
                          scoreController.updateScore(false);
                          scoreController.score.value += _temporaryScore.value;

                          Get.snackbar(
                            'Congratulations!',
                            'All items found!',
                            backgroundColor: AppColors.white,
                            colorText: Colors.green,
                          );
                          Get.to(() => const ScoreScreen());
                          _itemsLeft.value = 5;
                          _temporaryScore.value = 0;
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: const BorderSide(color: AppColors.secondary),
                        ),
                        backgroundColor: AppColors.white,
                        foregroundColor: AppColors.secondary,
                      ),
                      child: const Text(
                        'Skip',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 50.0),
                  Expanded(
                    child: Obx(() {
                      return ElevatedButton(
                        onPressed: _isButtonEnabled.value
                            ? () async {
                                final image = await Get.to(() => CameraScreen(
                                      item: _randomFruit.value,
                                      emoji: _randomFruitEmoji.value,
                                    ));

                                if (image != null) {
                                  bool isCorrect = false;
                                  String answer =
                                      imageController.label.value.toLowerCase();

                                  if (answer ==
                                          _randomFruit.value.toLowerCase() &&
                                      imageController.confidence.value > 65) {
                                    isCorrect = true;
                                    _temporaryScore.value += 100;
                                  }
                                  _showFlashingText(isCorrect);

                                  Future.delayed(
                                    const Duration(seconds: 3),
                                    () {
                                      _generateRandomFruit();
                                    },
                                  );

                                  if (_itemsLeft.value <= 0) {
                                    scoreController.updateScore(true);
                                    scoreController.score.value +=
                                        _temporaryScore.value;

                                    Get.snackbar(
                                      'Congratulations!',
                                      'All items found!',
                                      backgroundColor: AppColors.white,
                                      colorText: Colors.green,
                                    );
                                    Get.to(() => const ScoreScreen());
                                    _itemsLeft.value = 5;
                                    _temporaryScore.value = 0;
                                  }
                                } else {
                                  _generateRandomFruit();
                                }
                              }
                            : null, // Button is disabled if _isButtonEnabled is false
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          backgroundColor: AppColors.secondary,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text(
                          'Take photo',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
