import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PremiumSliderSection extends StatefulWidget {
  const PremiumSliderSection({super.key});

  @override
  State<PremiumSliderSection> createState() => _PremiumSliderSectionState();
}

class _PremiumSliderSectionState extends State<PremiumSliderSection> {
  final PageController _pageController = PageController(viewportFraction: 0.96);
  int currentIndex = 0;
  late Timer timer;

  final List<Map<String, dynamic>> sliderData = [
    {
      "title": "Isha Kriya",
      "subtitle": "Guided meditation for inner transformation",
      "image": "https://images.unsplash.com/photo-1506126613408-eca07ce68773",
    },
    {
      "title": "Inner Engineering",
      "subtitle": "Powerful yogic science for wellbeing",
      "image": "https://images.unsplash.com/photo-1518611012118-fb328c1f2988",
    },
    {
      "title": "Daily Yoga",
      "subtitle": "Create peace and balance everyday",
      "image": "https://images.unsplash.com/photo-1545389336-cf090694435e",
    },
  ];

  @override
  void initState() {
    super.initState();
    startAutoSlide();
  }

  void startAutoSlide() {
    timer = Timer.periodic(
      const Duration(seconds: 7),
      (timer) {
        if (currentIndex < sliderData.length - 1) {
          currentIndex++;
        } else {
          currentIndex = 0;
        }
        _pageController.animateToPage(
          currentIndex,
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastOutSlowIn,
        );
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 280,
          child: PageView.builder(
            controller: _pageController,
            itemCount: sliderData.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final item = sliderData[index];
              final bool isActive = currentIndex == index;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutQuart,
                margin: EdgeInsets.only(
                  right: 0,
                  top: isActive ? 0 : 20,
                  bottom: isActive ? 0 : 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    if (isActive)
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 12),
                      ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        item["image"],
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.0, 0.4, 1.0],
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.2),
                              Colors.black.withValues(alpha: 0.85),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.3),
                                ),
                              ),
                              child: const Text(
                                "PREMIUM",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              item["title"],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              item["subtitle"],
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.85),
                                fontSize: 15,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 40),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 14,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF18B7BE),
                                    borderRadius: BorderRadius.circular(12
                                                          ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF18B7BE)
                                            .withValues(alpha: 0.4),
                                        blurRadius: 12,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Explore Now",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 14),
        SmoothPageIndicator(
          controller: _pageController,
          count: sliderData.length,
          effect: ExpandingDotsEffect(
            activeDotColor: const Color(0xFF18B7BE),
            dotColor: Colors.grey.withValues(alpha: 0.3),
            dotHeight: 6,
            dotWidth: 6,
            expansionFactor: 4,
          ),
        ),
      ],
    );
  }
}