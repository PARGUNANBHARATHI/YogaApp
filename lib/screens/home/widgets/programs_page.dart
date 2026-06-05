import 'package:flutter/material.dart';

class ProgramsPage extends StatelessWidget {
  const ProgramsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color(0xFFF5F6FB),

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(20),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              // ================= HEADER =================

              Row(

                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                children: [

                  const Text(

                    "Programs",

                    style: TextStyle(

                      fontSize: 28,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  Container(

                    height: 46,
                    width: 46,

                    decoration: BoxDecoration(

                      color: Colors.white,

                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),
                    ),

                    child: const Icon(
                      Icons.workspace_premium_outlined,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              buildSection(

                title: "For Him & Her",

                subtitle:
                    "Special practices designed to balance energy and support unique needs.",

                cards: const [

                  ProgramCard(
                    title: "Male Power",
                    duration: "4 min",
                    emoji: "🛡️",
                  ),

                  ProgramCard(
                    title: "Female Wisdom",
                    duration: "6 min",
                    emoji: "🌸",
                  ),
                ],
              ),

              const SizedBox(height: 24),

              buildSection(

                title: "Healthy Habits",

                subtitle:
                    "Focused sessions to restore inner balance and wellbeing.",

                cards: const [

                  ProgramCard(
                    title: "Nicotine Relief",
                    duration: "2 min",
                    emoji: "🌱",
                  ),

                  ProgramCard(
                    title: "Appetite Control",
                    duration: "7 min",
                    emoji: "🍏",
                  ),

                  ProgramCard(
                    title: "Recovery",
                    duration: "7 min",
                    emoji: "🕊️",
                  ),
                ],
              ),

              const SizedBox(height: 24),

              buildSection(

                title: "Mindful Breathing",

                subtitle:
                    "Simple daily practices to stay calm and energized.",

                cards: const [

                  ProgramCard(
                    title: "Stress Relief",
                    duration: "4 min",
                    emoji: "🌳",
                  ),

                  ProgramCard(
                    title: "Freedom",
                    duration: "5 min",
                    emoji: "🦋",
                  ),
                ],
              ),

              const SizedBox(height: 24),

              buildSection(

                title: "Breath Journeys",

                subtitle:
                    "Modern breathing practices inspired by yoga.",

                cards: const [

                  ProgramCard(
                    title: "Rhythmic Breathing",
                    duration: "5 min",
                    emoji: "🥁",
                  ),

                  ProgramCard(
                    title: "Box Breathing",
                    duration: "6 min",
                    emoji: "🧊",
                  ),

                  ProgramCard(
                    title: "Kapalabhati",
                    duration: "3 min",
                    emoji: "🐉",
                  ),
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSection({

    required String title,

    required String subtitle,

    required List<Widget> cards,
  }) {

    return Column(

      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        Text(

          title,

          style: const TextStyle(

            fontSize: 22,

            fontWeight:
                FontWeight.bold,
          ),
        ),

        const SizedBox(height: 6),

        Text(

          subtitle,

          style: TextStyle(

            fontSize: 14,

            color: Colors.grey.shade700,
          ),
        ),

        const SizedBox(height: 14),

        GridView.builder(

          shrinkWrap: true,

          physics:
              const NeverScrollableScrollPhysics(),

          itemCount: cards.length,

          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(

            crossAxisCount: 2,

            crossAxisSpacing: 12,

            mainAxisSpacing: 12,

            mainAxisExtent: 160,
          ),

          itemBuilder: (context, index) {
            return cards[index];
          },
        ),
      ],
    );
  }
}

// ================= CARD =================

class ProgramCard extends StatelessWidget {

  final String title;
  final String duration;
  final String emoji;

  const ProgramCard({

    super.key,

    required this.title,

    required this.duration,

    required this.emoji,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(16),

        boxShadow: [

          BoxShadow(

            color:
                Colors.black.withValues(
              alpha: 0.03,
            ),

            blurRadius: 10,

            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Text(
            emoji,
            style: const TextStyle(
              fontSize: 40,
            ),
          ),

          const SizedBox(height: 10),

          Expanded(

            child: Text(

              title,

              maxLines: 2,

              overflow:
                  TextOverflow.ellipsis,

              style: const TextStyle(

                fontSize: 15,

                fontWeight:
                    FontWeight.w700,

                height: 1.2,
              ),
            ),
          ),

          Container(

            padding:
                const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),

            decoration: BoxDecoration(

              color:
                  const Color(0xFFF4F6F8),

              borderRadius:
                  BorderRadius.circular(
                8,
              ),
            ),

            child: Text(

              duration,

              style: TextStyle(

                fontSize: 11,

                fontWeight:
                    FontWeight.w600,

                color:
                    Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
    
  }
}
