// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:get/get.dart';
import 'package:my_tflit_app/core/utils/constant.dart';

class ImageController extends GetxController {
  static ImageController get to => Get.find();

  var filePath = Rx<File?>(null);
  var label = ''.obs;
  var confidence = 0.0.obs;
  var resultText = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _tfLteInit();
  }

  Future<void> _tfLteInit() async {
    await Tflite.loadModel(
      model: FRUIT_TFLITE_MODEL,
      labels: FRUIT_TFLITE_LABEL,
      numThreads: 1,
      isAsset: true,
      useGpuDelegate: false,
    );
  }

  Future<void> processImage(String imagePath, String object) async {
    filePath.value = File(imagePath);

    // Show loading indicator
    isLoading.value = true;

    // Show dialog with CircularProgressIndicator
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );

    // Simulate processing delay
    await Future.delayed(const Duration(seconds: 2));

    // Close the CircularProgressIndicator
    Get.back();

    // Run the model on the selected image
    await _runModelOnImage(imagePath, object);

    // Hide loading indicator
    isLoading.value = false;

    // Check the confidence level and show dialog if applicable
    if (confidence.value >= 65) {
      // _showResultDialog(object);
      log('Correct');
    } else {
      Get.snackbar('Warning', 'Image may be blurry, please take again',
          backgroundColor: Colors.white, colorText: Colors.red);
    }
  }

  Future<void> _runModelOnImage(String path, String randomFruit) async {
    var recognitions = await Tflite.runModelOnImage(
      path: path,
      imageMean: 127.5,
      imageStd: 127.5,
      numResults: 2,
      threshold: 0.2,
      asynch: true,
    );

    if (recognitions != null && recognitions.isNotEmpty) {
      confidence.value = recognitions[0]['confidence'] * 100;
      label.value = recognitions[0]['label'].toString().split(' ').last;
      String object =
          label.value = recognitions[0]['label'].toString().split(' ').last;
      String confidences = confidence.value.toString();
      log('Object: $object\nQuest: $randomFruit\nConfidence: $confidences');
    } else {
      confidence.value = 0.0;
      label.value = '';
    }
  }

  // void _showResultDialog(String obj) {
  //   bool correct = label.value.toLowerCase() == obj.toLowerCase();

  //   Get.dialog(
  //     CorrectDialog(isCorrect: correct),
  //   );
  // }

  void clearImage() {
    filePath.value = null;
    label.value = '';
    confidence.value = 0.0;
  }

  @override
  void onClose() {
    Tflite.close();
    super.onClose();
  }
}
