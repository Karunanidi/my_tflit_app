import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_tflit_app/core/utils/appcolors.dart';
import 'package:my_tflit_app/presentation/detector_screen/intro_screen.dart';
import 'package:my_tflit_app/presentation/onboardning_screen/onboarding_screen.dart';
import 'package:my_tflit_app/presentation/score_screen/controller/score_controller.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final ScoreController controller = Get.find<ScoreController>();

  final List<Map<String, String>> huntOptions = [
    {
      'img':
          'https://img.freepik.com/free-psd/fruits-still-life-background_23-2151102768.jpg?t=st=1725098038~exp=1725101638~hmac=489fd784b10902c5063153441ecdc04d90ed540a5840e694167f701b2d90ecc3&w=1060',
      'title': 'Fruits Hunt',
    },
    {
      'img':
          'https://img.freepik.com/free-photo/gift-voucher-3d-rendering_23-2149174193.jpg?t=st=1725097951~exp=1725101551~hmac=f4a42ca87c70425d3e14bdb52e9aa7637232e03fd2b27a848f2a5826d8af08da&w=1060',
      'title': 'coming soon..',
    },
  ];

  final List<String> carouselImages = [
    'https://img.freepik.com/free-photo/white-bengal-tiger-wilderness_23-2151528275.jpg?t=st=1725098552~exp=1725102152~hmac=752075bf9027df8275b51c0261a6b4b763249f1d1e7bee9a5dece1cc117b1725&w=1060',
    'https://img.freepik.com/free-photo/gift-voucher-3d-rendering_23-2149174193.jpg?t=st=1725097951~exp=1725101551~hmac=f4a42ca87c70425d3e14bdb52e9aa7637232e03fd2b27a848f2a5826d8af08da&w=1060',
    'https://img.freepik.com/free-psd/fruits-still-life-background_23-2151102768.jpg?t=st=1725098038~exp=1725101638~hmac=489fd784b10902c5063153441ecdc04d90ed540a5840e694167f701b2d90ecc3&w=1060',
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
            'Hunter',
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
                              'Points 🪙 : ${controller.score.value}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Center(
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        child: const Text(
                          'Welcome Hunter! join the challenges, you will have a lots of fun',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16.0),
                        ),
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
                                    image,
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
                                            duration:
                                                Duration(milliseconds: 1500),
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
          Get.showSnackbar(GetSnackBar(
            message: title,
            duration: const Duration(milliseconds: 1500),
          ));
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
