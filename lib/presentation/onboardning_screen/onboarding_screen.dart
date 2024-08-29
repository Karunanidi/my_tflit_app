
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:my_tflit_app/core/utils/appcolors.dart';
import 'package:my_tflit_app/core/utils/constant.dart';
import 'package:my_tflit_app/core/utils/permission_helper.dart';
import 'package:my_tflit_app/presentation/home_page_screen/home_page_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController pageController = PageController();
  final ValueNotifier<bool> onLastPage = ValueNotifier<bool>(false);

  Future<void> _handlePermissionRequest() async {
    await PermissionsHelper.requestMediaPermissions();
  }

  @override
  void initState()  {
    _handlePermissionRequest();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    onLastPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              if (index == 2) {
                onLastPage.value = true;
              } else {
                onLastPage.value = false;
              }
            },
            children: [
              // ========== PAGE ONE ==========
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(LOTTIE_HOW_TO_PLAY),
                  const Text('how to play the game?'),
                ],
              ),

              // ========== PAGE TWO ==========
              Container(
                color: AppColors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      LOTTIE_START,
                    ),
                    const Text('Press the start button'),
                  ],
                ),
              ),

              // ========== PAGE THREE ==========
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 360,
                    child: Lottie.asset(
                      LOTTIE_VALIDATE,
                    ),
                  ),
                  const Text('scan the object and see the result!'),
                ],
              ),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  effect: const WormEffect(
                    dotColor: AppColors.grey,
                    activeDotColor: AppColors.tertiary,
                  ),
                  count: 3,
                ),
                const SizedBox(width: 14.0),
                ValueListenableBuilder<bool>(
                  valueListenable: onLastPage,
                  builder: (context, value, child) {
                    return value
                        ? Container(
                            height: 26,
                            child: ElevatedButton(
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      AppColors.tertiary)),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    });
                                Future.delayed(
                                  const Duration(milliseconds: 500),
                                  () {
                                    Get.back();
                                    Get.to(() => const HomePageScreen());
                                  },
                                );
                              },
                              child: const Text(
                                'Get Started',
                                style: TextStyle(
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          )
                        : const Text('');
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
