import 'package:flutter/material.dart';

class ProgramDetailsPage extends StatelessWidget {
  final String title;
  final String duration;

  const ProgramDetailsPage({
    super.key,
    required this.title,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F3),

      body: SingleChildScrollView(
        child: Column(
          children: [

            // ================= HERO =================

            Stack(
              children: [

                SizedBox(
                  height: 360,
                  width: double.infinity,

                  child: Image.network(
                    "https://images.unsplash.com/photo-1506126613408-eca07ce68773",
                    fit: BoxFit.cover,
                  ),
                ),

                Container(
                  height: 360,

                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,

                      colors: [
                        Colors.transparent,
                        Colors.black54,
                      ],
                    ),
                  ),
                ),

                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),

                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,

                      children: [

                        CircleAvatar(
                          backgroundColor:
                              Colors.white70,

                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),

                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),

                        CircleAvatar(
                          backgroundColor:
                              Colors.white70,

                          child: IconButton(
                            icon: const Icon(
                              Icons.share_outlined,
                              color: Colors.black,
                            ),

                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  bottom: 30,
                  left: 20,
                  right: 20,

                  child: Container(
                    padding:
                        const EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color:
                          Colors.white.withValues(
                        alpha: 0.18,
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        24,
                      ),
                    ),

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(
                          title,

                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Row(
                          children: [

                            Container(
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),

                              decoration:
                                  BoxDecoration(
                                color:
                                    Colors.white24,

                                borderRadius:
                                    BorderRadius.circular(
                                  20,
                                ),
                              ),

                              child: Text(
                                duration,

                                style:
                                    const TextStyle(
                                  color:
                                      Colors.white,
                                ),
                              ),
                            ),

                            const SizedBox(width: 10),

                            const Text(
                              "Meditation",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // ================= CONTENT =================

            Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    "$title is a guided practice designed to improve focus, inner balance and wellbeing.",

                    style: TextStyle(
                      fontSize: 16,
                      color:
                          Colors.grey.shade700,
                      height: 1.7,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ================= BUTTON =================

                  Container(
                    width: double.infinity,
                    height: 62,

                    decoration: BoxDecoration(
                      gradient:
                          const LinearGradient(
                        colors: [
                          Color(0xFF14B8A6),
                          Color(0xFF0EA5E9),
                        ],
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        18,
                      ),
                    ),

                    child: ElevatedButton.icon(
                      onPressed: () {},

                      icon: const Icon(
                        Icons.play_arrow_rounded,
                      ),

                      label: const Text(
                        "Start Practice",
                      ),

                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.transparent,
                        shadowColor:
                            Colors.transparent,
                        foregroundColor:
                            Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ================= ACTIONS =================

                  Row(
                    children: [

                      _actionCard(
                        Icons.play_circle_outline,
                        "Intro",
                      ),

                      const SizedBox(width: 12),

                      _actionCard(
                        Icons.menu_book_outlined,
                        "Learn",
                      ),

                      const SizedBox(width: 12),

                      _actionCard(
                        Icons.calendar_month,
                        "Schedule",
                      ),
                    ],
                  ),

                  const SizedBox(height: 35),

                  const Text(
                    "Benefits",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  _benefit(
                    "🌞 Increase Energy",
                  ),

                  _benefit(
                    "🧠 Improve Focus",
                  ),

                  _benefit(
                    "🌿 Reduce Stress",
                  ),

                  _benefit(
                    "💪 Build Confidence",
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Guidelines",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  _faq(
                    "Enable Do Not Disturb",
                  ),

                  _faq(
                    "Light stomach recommended",
                  ),

                  _faq(
                    "Sit with palms open",
                  ),

                  _faq(
                    "Keep phone silent",
                  ),

                  const SizedBox(height: 35),

                  const Text(
                    "Related Content",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Container(
                    height: 220,

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius:
                          BorderRadius.circular(
                        22,
                      ),
                    ),

                    child: Column(
                      children: [

                        Expanded(
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.vertical(
                              top:
                                  Radius.circular(
                                22,
                              ),
                            ),

                            child: Image.network(
                              "https://images.unsplash.com/photo-1545205597-3d9d02c29597",
                              width:
                                  double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        const Padding(
                          padding:
                              EdgeInsets.all(16),

                          child: Text(
                            "Yoga For Inner Balance",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 35),

                  Container(
                    padding:
                        const EdgeInsets.all(24),

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius:
                          BorderRadius.circular(
                        28,
                      ),
                    ),

                    child: const Column(
                      children: [

                        Icon(
                          Icons.format_quote,
                          size: 48,
                          color:
                              Color(0xFF14B8A6),
                        ),

                        SizedBox(height: 10),

                        Text(
                          "Joy is a natural phenomenon. Misery is your creation.",
                          textAlign:
                              TextAlign.center,

                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight.w500,
                          ),
                        ),

                        SizedBox(height: 16),

                        Text(
                          "இறை— IRAi & You",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _actionCard(
    IconData icon,
    String title,
  ) {
    return Expanded(
      child: Container(
        height: 100,

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
              BorderRadius.circular(18),
        ),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            Icon(icon),

            const SizedBox(height: 10),

            Text(title),
          ],
        ),
      ),
    );
  }

  static Widget _benefit(String title) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 12),

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: const Color(0xFFF7F3E8),

        borderRadius:
            BorderRadius.circular(18),
      ),

      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static Widget _faq(String title) {
    return Card(
      elevation: 0,

      child: ExpansionTile(
        title: Text(title),

        children: const [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Follow this instruction before starting your practice.",
            ),
          ),
        ],
      ),
    );
  }
}