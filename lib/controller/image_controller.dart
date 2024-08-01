import 'dart:io';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  static ImageController get to => Get.find();

  var filePath = Rx<File?>(null);
  var label = ''.obs;
  var confidence = 0.0.obs;
  var resultText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _tfLteInit();
  }

  Future<void> _tfLteInit() async {
    await Tflite.loadModel(
      model: "assets/model_test.tflite",
      labels: "assets/labels.txt",
      numThreads: 1,
      isAsset: true,
      useGpuDelegate: false,
    );
  }

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: source);

    if (image == null) return;

    filePath.value = File(image.path);
    await _runModelOnImage(image.path);
  }

  Future<void> _runModelOnImage(String path) async {
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
      _setResultText(label.value);
    } else {
      confidence.value = 0.0;
      label.value = '';
      resultText.value = 'unidentified';
    }
  }

  void _setResultText(String label) {
    if (label == 'mouse') {
      resultText.value = 'gotcha';
    } else if (label == 'laptop') {
      resultText.value = 'keep it';
    } else {
      resultText.value = 'unidentified';
    }
  }

  @override
  void onClose() {
    Tflite.close();
    super.onClose();
  }
}
