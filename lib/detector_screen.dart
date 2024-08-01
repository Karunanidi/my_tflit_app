import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_tflit_app/controller/image_controller.dart';

class DetectorScreen extends StatelessWidget {
  const DetectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final imageController = ImageController.to;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Object Detector"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
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
                                    image: AssetImage('assets/upload.jpg'),
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Obx(() {
                              return Text(
                                imageController.label.value,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }),
                            const SizedBox(height: 12),
                            Obx(() {
                              return Text(
                                imageController.confidence.value == 0
                                    ? "The Accuracy is --"
                                    : "The Accuracy is ${imageController.confidence.value.toStringAsFixed(0)}%",
                                style: const TextStyle(fontSize: 18),
                              );
                            }),
                            const SizedBox(height: 12),
                            Obx(() {
                              return Text(
                                imageController.resultText.value,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              );
                            }),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => imageController.pickImage(ImageSource.camera),
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
                onPressed: () => imageController.pickImage(ImageSource.gallery),
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
    );
  }
}
