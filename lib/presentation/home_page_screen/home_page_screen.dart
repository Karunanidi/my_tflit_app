import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_tflit_app/components/custom_image_view.dart';
import 'package:my_tflit_app/core/utils/appcolors.dart';
import 'package:my_tflit_app/presentation/detector_screen/intro_screen.dart';
import 'package:my_tflit_app/presentation/score_screen/controller/score_controller.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final ScoreController controller = Get.put(ScoreController());

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: const Text(
          'Home Screen',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: const SizedBox(),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(
                    () => Text(
                      'Points : ${controller.score.value}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14.0),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              const Center(
                child: Text(
                  'Oportet uti solum de actibus prosecutionem et fugam, haec leniter et blandus et reservato.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Daily Challenge',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              const SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: CustomImageView(
                          imagePath:
                              'https://images.unsplash.com/photo-1704694214588-24f4bae4757b?q=80&w=1770&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                          fit: BoxFit.cover,
                          blendMode: BlendMode.darken,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Title',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: AppColors.primary),
                          ),
                          const SizedBox(height: 10.0),
                          const Text(
                            'Tollere odium autem in nostra potestate sint,',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  duration: Duration(seconds: 1),
                                  content: Text('Clicked'),
                                ),
                              );
                            },
                            child: const Text('Let\'s Try'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Pick Your Hunt',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Get.to(() => const IntroScreen());
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: Image.network(
                                  'https://images.unsplash.com/photo-1704694214588-24f4bae4757b?q=80&w=1770&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                  fit: BoxFit.cover,
                                  color: Colors.black.withOpacity(0.5),
                                  colorBlendMode: BlendMode.darken,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: 80,
                                    width: 100,
                                  ),
                                  const SizedBox(height: 10.0),
                                  const Text(
                                    'Hunt Option 1',
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Get.to(() => const IntroScreen());
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: Image.network(
                                  'https://images.unsplash.com/photo-1704694214588-24f4bae4757b?q=80&w=1770&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                  fit: BoxFit.cover,
                                  color: Colors.black.withOpacity(0.5),
                                  colorBlendMode: BlendMode.darken,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: 80,
                                    width: 100,
                                  ),
                                  const SizedBox(height: 10.0),
                                  const Text(
                                    'Hunt Option 2',
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
