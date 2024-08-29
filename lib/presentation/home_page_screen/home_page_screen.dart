import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:my_tflit_app/core/utils/appcolors.dart';
import 'package:my_tflit_app/core/utils/constant.dart';
import 'package:my_tflit_app/presentation/detector_screen/intro_screen.dart';
import 'package:my_tflit_app/presentation/onboardning_screen/onboarding_screen.dart';
import 'package:my_tflit_app/presentation/score_screen/controller/score_controller.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final ScoreController controller = Get.put(ScoreController());

  final List<Map<String, String>> huntOptions = [
    {
      'img':
          'https://plus.unsplash.com/premium_photo-1671379041175-782d15092945?q=80&w=1920&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'title': 'Fruits Hunt',
    },
    {
      'img':
          'https://img.freepik.com/premium-vector/search-new-ideas-meeting-brainstorming-business-concept-vector-illustration_114835-151.jpg?w=826',
      'title': 'coming soon..',
    },
    {
      'img':
          'https://img.freepik.com/premium-vector/search-new-ideas-meeting-brainstorming-business-concept-vector-illustration_114835-151.jpg?w=826',
      'title': 'coming soon..',
    },
  ];

  final List<String> carouselImages = [
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
  ];

  int _currentCarouselIndex = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // Future<void> _refresh() async {
  //   await Future.delayed(const Duration(seconds: 1));
  //   setState(() {
  //     huntOptions;
  //   });
  // }

  _onPop(didpop) {
    if (didpop) {
      return;
    }
    Get.offAll(() => const OnboardingScreen());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didpop) {
        _onPop(didpop);
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          centerTitle: true,
          leading: const SizedBox(),
          title: const Text(
            'Home Page',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(0.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
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
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: const Text(
                        'Daily Challenge',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    CarouselSlider(
                      items: carouselImages.map((image) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: Image.network(
                                    IMG_DUMMY,
                                    fit: BoxFit.cover,
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
                                    Flexible(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Get.showSnackbar(const GetSnackBar(
                                            message: 'soon available',
                                          ));
                                        },
                                        child: const Text('Let\'s Try'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 2.0,
                        autoPlayInterval: const Duration(seconds: 5),
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentCarouselIndex = index;
                          });
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: carouselImages.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => setState(() {
                            _currentCarouselIndex = entry.key;
                          }),
                          child: Container(
                            width: 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentCarouselIndex == entry.key
                                  ? Colors.blueAccent
                                  : Colors.grey,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: const Text(
                        'Pick Your Hunt',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 1.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final option = huntOptions[index];
                    return huntOptionCard(option['img']!, option['title']!);
                  },
                  childCount: huntOptions.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget huntOptionCard(String img, String title) {
    return InkWell(
      onTap: () {
        if (title.toLowerCase() == 'fruits hunt') {
          Get.to(() => const IntroScreen());
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(milliseconds: 1500),
              content: Text(title),
            ),
          );
        }
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
                  img,
                  fit: BoxFit.cover,
                  colorBlendMode: BlendMode.darken,
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                    width: 100,
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
