import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:my_tflit_app/presentation/detector_screen/controller/image_controller.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key, required this.item});
  final String item;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isInitialized = false;
  late Timer _timer;
  int _seconds = 15;
  RxString _timerText = '15'.obs;
  final imageController = ImageController.to;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _startTimer();
  }

  @override
  void dispose() {
    log('------- start dispose -------');
    _controller?.dispose();
    _timer.cancel();
    super.dispose();
    log('------- start dispose -------');
  }

  void _initializeCamera() async {
    _cameras = await availableCameras();
    _controller = CameraController(_cameras![0], ResolutionPreset.medium);
    await _controller?.initialize();
    setState(() {
      _isInitialized = true;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds--;
        _timerText.value = _seconds.toString();
      });

      if (_seconds <= 0) {
        timer.cancel();
        Get.snackbar('Time\'s up!', 'Please try again.',
            backgroundColor: Colors.white, colorText: Colors.red);
        Navigator.pop(context);
      }
    });
  }

  void _takePicture() async {
    if (_controller != null && _controller!.value.isInitialized) {
      XFile image = await _controller!.takePicture();
      await imageController.processImage(image.path, widget.item);

      Navigator.pop(context, image);
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    if (!_isInitialized || _controller == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Stack(
          children: [
            Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Timer Section
                  Obx(() => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Time left: ${_timerText.value}s ⏰',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      )),

                  // Item Section
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Item: ${widget.item} 🍋',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 60),
              height: h,
              child: ClipRRect(
                child: CameraPreview(_controller!),
              ),
            ),
            Positioned(
              bottom: 20,
              left: MediaQuery.of(context).size.width / 2 - 30,
              child: FloatingActionButton(
                onPressed: _takePicture,
                child: const Icon(Icons.camera),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
