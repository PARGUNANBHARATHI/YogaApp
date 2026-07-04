import 'package:flutter/material.dart';

import '../../data/dummy_data/yoga_data.dart';
import 'widgets/premium_hero_section.dart';
import 'widgets/recommended_card.dart';
import 'widgets/wellness_slider.dart';
import 'widgets/premium_slider_section.dart';




class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;

  int selectedCategory = 0;

  final List<String> categories = [
    // "All",
    // "Meditation",
    // "Stretch",
    // "Strength",
    // "Relax",
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF5F1EA),

      // ================= BODY =================

      body: SafeArea(

        child: CustomScrollView(

          physics:
              const BouncingScrollPhysics(),

          slivers: [

            // ================= HEADER =================

            SliverToBoxAdapter(

              child: Padding(

                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    // ================= PREMIUM HERO =================

                    const PremiumHeroSection(),

                    const SizedBox(height: 20),
                // ================= PREMIUM POSTER =================

                    const PremiumSliderSection(),

                     const SizedBox(height: 20),

                    

                     const SizedBox(height: 4),

                    // ================= CATEGORIES =================

                    SizedBox(

  height: 35,

  child: ListView.builder(

    scrollDirection: Axis.horizontal,

    itemCount: categories.length,

    itemBuilder: (context, index) {

      final isSelected =
          selectedCategory == index;

      return GestureDetector(

        onTap: () {

          setState(() {
            selectedCategory = index;
          });
        },

        child: AnimatedContainer(

          duration:
              const Duration(
            milliseconds: 220,
          ),

          margin:
              const EdgeInsets.only(
            right: 10,
          ),

          padding:
              const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),

          decoration: BoxDecoration(

            gradient: isSelected

                ? const LinearGradient(

                    colors: [

                      Color(0xFF2FA7B2),
                      Color(0xFF58C4C9),
                    ],
                  )

                : null,

            color: isSelected
                ? null
                : Colors.white,

            borderRadius:
                BorderRadius.circular(10),

            boxShadow: [

              if (isSelected)

                BoxShadow(

                  color:
                      const Color(
                    0xFF2FA7B2,
                  ).withValues(
                    alpha: 0.18,
                  ),

                  blurRadius: 10,

                  offset:
                      const Offset(0, 6),
                ),
            ],
          ),

          child: Center(

            child: Text(

              categories[index],

              style: TextStyle(

                fontSize: 13,

                color: isSelected
                    ? Colors.white
                    : const Color(
                        0xFF2B2927,
                      ),

                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ),
        ),
      );
    },
  ),
),

const SizedBox(height: 20),

                    // ================= RECOMMENDED =================

                    const Text(

                      "Recommended For You",

                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -1,
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(

                      height: 360,
                      
                      child: ListView(

                        scrollDirection:
                            Axis.horizontal,

                        children: [

                          RecommendedCard(
                            title: "Morning Flow",

                            subtitle:
                                "Start your day fresh",

                            image:
                                "https://images.unsplash.com/photo-1506126613408-eca07ce68773",
                          ),

                          RecommendedCard(
                            title: "Deep Relax",

                            subtitle:
                                "Reduce stress & anxiety",

                            image:
                                "https://images.unsplash.com/photo-1518611012118-696072aa579a",
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),













// ================= WELLNESS SECTION  LENTH CONTAINER =================


SliverList(
  delegate: SliverChildBuilderDelegate(

    (context, index) {

      final yoga = yogaSessions[index];

      return Container(

        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 8,
        ),

        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius:
              BorderRadius.circular(12),

          border: Border.all(
            color: const Color(0xFFEAE6DF),
          ),
        ),

        child: Row(

          children: [

            // IMAGE

            ClipRRect(

              borderRadius:
                  BorderRadius.circular(8),

              child: Image.network(

                yoga.image,

                width: 56,
                height: 56,

                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 12),

            // CONTENT

            Expanded(

              child: Column(

                mainAxisSize: MainAxisSize.min,

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(

                    yoga.title,

                    maxLines: 1,

                    overflow:
                        TextOverflow.ellipsis,

                    style: const TextStyle(

                      fontSize: 16,

                      fontWeight:
                          FontWeight.w700,

                      color:
                          Color(0xFF2B2927),
                    ),
                  ),

                  const SizedBox(height: 4),

                  Row(

                    children: [

                      Container(

                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),

                        decoration: BoxDecoration(

                          color:
                              const Color(0xFFEDF8F8),

                          borderRadius:
                              BorderRadius.circular(
                            6,
                          ),
                        ),

                        child: const Text(

                          "Meditation",

                          style: TextStyle(

                            fontSize: 11,

                            fontWeight:
                                FontWeight.w600,

                            color:
                                Color(0xFF2FA7B2),
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      Text(

                        yoga.level,

                        style: const TextStyle(

                          fontSize: 12,

                          color:
                              Color(0xFF7A746B),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // AUDIO BUTTON

            Container(

              height: 38,
              width: 38,

              decoration: BoxDecoration(

                color:
                    const Color(0xFFF5F1EA),

                borderRadius:
                    BorderRadius.circular(
                  10,
                ),
              ),

              child: const Icon(

                Icons.headphones_rounded,

                size: 20,

                color:
                    Color(0xFF2FA7B2),
              ),
            ),
          ],
        ),
      );
    },

    childCount:
        yogaSessions.length > 4
            ? 4
            : yogaSessions.length,
  ),
),






// ================= WELLNESS SECTION =================

const SliverToBoxAdapter(

  child: Padding(

    padding: EdgeInsets.only(
      top: 40,
      bottom: 40,
    ),

    child: WellnessSlider(),
  ),
),


            // ================= BOTTOM SPACE =================

            const SliverToBoxAdapter(
              child: SizedBox(height: 10),
            ),
          ],
        ),
      ),
    );
  }
}