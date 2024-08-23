import 'dart:math';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_tflit_app/core/utils/appcolors.dart';
import 'package:my_tflit_app/presentation/detector_screen/controller/image_controller.dart';

class DetectorScreen extends StatefulWidget {
  const DetectorScreen({super.key});

  @override
  State<DetectorScreen> createState() => _DetectorScreenState();
}

class _DetectorScreenState extends State<DetectorScreen> {
  final imageController = ImageController.to;
  final List<String> _objects = [
    "Apple",
    "Banana",
    "Carrot",
    "Corn",
    "Garlic",
    "Ginger",
    "Grape",
    "Kiwi",
    "Lemon",
    "Mango",
    "Orange",
    "Pear",
    "Pineapple",
    "Potato",
    "Tomato",
    "Watermelon"
  ];
  final RxString _randomFruit = 'randomize'.obs;

  void _generateRandomFruit() {
    final random = Random();
    _randomFruit.value = _objects[random.nextInt(_objects.length)];
    imageController.clearImage();
  }

  @override
  void initState() {
    super.initState();
    _generateRandomFruit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Huntress"),
        leading: const SizedBox(),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Obx(() {
                    return imageController.isLoading.value
                        ? const SizedBox.shrink()
                        : Container();
                  }),
                  const SizedBox(height: 12),
                  Card(
                    elevation: 20,
                    clipBehavior: Clip.hardEdge,
                    child: SizedBox(
                      width: 300,
                      child: Column(
                        children: [
                          const SizedBox(height: 18),
                          Obx(() {
                            return Container(
                              height: 280,
                              width: 280,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                image: imageController.filePath.value == null
                                    ? const DecorationImage(
                                        image: AssetImage('assets/ic_add_image.png'),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child: imageController.filePath.value == null
                                  ? const SizedBox()
                                  : Image.file(
                                      imageController.filePath.value!,
                                      fit: BoxFit.cover,
                                    ),
                            );
                          }),
                          const SizedBox(height: 12),
                          Obx(() {
                            return Text(
                              _randomFruit.value,
                              style: const TextStyle(fontSize: 18),
                            );
                          }),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: _generateRandomFruit,
                            child: const Text('New Generate'),
                          ),
                          const SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => imageController.pickImage(
                        ImageSource.camera, _randomFruit.value),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                      foregroundColor: Colors.black,
                    ),
                    child: const Text("Take a Photo"),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => imageController.pickImage(
                        ImageSource.gallery, _randomFruit.value),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                      foregroundColor: Colors.black,
                    ),
                    child: const Text("Pick from gallery"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
