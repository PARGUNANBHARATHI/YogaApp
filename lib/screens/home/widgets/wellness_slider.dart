import 'package:flutter/material.dart';

class WellnessSlider extends StatefulWidget {
  const WellnessSlider({super.key});

  @override
  State<WellnessSlider> createState() => _WellnessSliderState();
}

class _WellnessSliderState extends State<WellnessSlider> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController =
        PageController(viewportFraction: 0.92);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(

      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        // ================= TITLE =================

        const Padding(

          padding:
              EdgeInsets.symmetric(
            horizontal: 20,
          ),

          child: Text(

            "Daily Wellness",

            style: TextStyle(

              fontSize: 22,

              fontWeight:
                  FontWeight.bold,

              letterSpacing: -0.5,
            ),
          ),
        ),

        const SizedBox(height: 12),

        // ================= SLIDER =================

        SizedBox(

          height: 95,

          child: PageView(

            controller: _pageController,

            children: [

              wellnessCard(

                title: "Health Test",

                score: "01/10",

                subtitle:
                    "Complete wellness check",

                gradient: const [

                  Color(0xFFFFFFFF),

                  Color(0xFFE0F7F5),
                ],

                glowColor:
                    const Color(0xFF06D6A0),

                icon:
                    Icons.verified_rounded,
              ),

              wellnessCard(

                title: "Meditation",

                score: "82%",

                subtitle:
                    "Calmness level today",

                gradient: const [

                  Color(0xFFEEF2FF),

                  Color(0xFFE0EAFF),
                ],

                glowColor:
                    const Color(0xFF8B5CF6),

                icon: Icons
                    .self_improvement_rounded,
              ),

              wellnessCard(

                title: "Sleep Quality",

                score: "7h 45m",

                subtitle:
                    "Better than yesterday",

                gradient: const [

                  Color(0xFFECFEFF),

                  Color(0xFFE0F2FE),
                ],

                glowColor:
                    const Color(0xFF06B6D4),

                icon:
                    Icons.nightlight_round,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ================= CARD =================

  Widget wellnessCard({

    required String title,

    required String score,

    required String subtitle,

    required List<Color> gradient,

    required Color glowColor,

    required IconData icon,
  }) {

    return Container(

      margin: const EdgeInsets.only(
        left: 20,
        right: 8,
      ),

      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(

        borderRadius:
            BorderRadius.circular(14),

        gradient: LinearGradient(

          begin: Alignment.topLeft,

          end: Alignment.bottomRight,

          colors: gradient,
        ),

        boxShadow: [

          BoxShadow(

            color:
                glowColor.withValues(
              alpha: 0.12,
            ),

            blurRadius: 12,

            offset:
                const Offset(0, 4),
          ),
        ],
      ),

      child: Row(

        children: [

          // ================= TEXT =================

          Expanded(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              mainAxisAlignment:
                  MainAxisAlignment.center,

              children: [

                Text(

                  title,

                  maxLines: 1,

                  overflow:
                      TextOverflow.ellipsis,

                  style: const TextStyle(

                    fontSize: 16,

                    fontWeight:
                        FontWeight.w700,

                    color:
                        Color(0xFF1E1E1E),
                  ),
                ),

                const SizedBox(height: 3),

                Text(

                  score,

                  style: TextStyle(

                    fontSize: 13,

                    fontWeight:
                        FontWeight.bold,

                    color:
                        Colors.grey.shade700,
                  ),
                ),

                const SizedBox(height: 2),

                Text(

                  subtitle,

                  maxLines: 1,

                  overflow:
                      TextOverflow.ellipsis,

                  style: TextStyle(

                    fontSize: 11,

                    color:
                        Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // ================= ICON =================

          Container(

            height: 45,
            width: 45,

            decoration: BoxDecoration(

              shape: BoxShape.circle,

              color:
                  glowColor.withValues(
                alpha: 0.12,
              ),
            ),

            child: Icon(

              icon,

              size: 20,

              color: glowColor,
            ),
          ),
        ],
      ),
    );
  }
}