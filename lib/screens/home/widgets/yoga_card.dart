import 'package:flutter/material.dart';

class YogaCard extends StatelessWidget {

  final String title;
  final String time;
  final String level;
  final String calories;
  final String image;

  const YogaCard({
    super.key,
    required this.title,
    required this.time,
    required this.level,
    required this.calories,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(26),

        boxShadow: [

          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),

            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          // ================= IMAGE =================

          ClipRRect(

            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(26),
            ),

            child: Image.network(

              image,

              height: 120,
              width: double.infinity,

              fit: BoxFit.cover,
            ),
          ),

          // ================= CONTENT =================

          Expanded(

            child: Padding(

              padding: const EdgeInsets.all(12),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                children: [

                  // ================= TITLE =================

                  Text(

                    title,

                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // ================= CHIPS =================

                  Row(

                    children: [

                      infoChip(time),

                      const SizedBox(width: 6),

                      Expanded(
                        child: infoChip(level),
                      ),
                    ],
                  ),

                  // ================= FOOTER =================

                  Row(

                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,

                    children: [

                      Flexible(

                        child: Row(

                          children: [

                            const Icon(
                              Icons.local_fire_department,
                              color: Colors.orange,
                              size: 16,
                            ),

                            const SizedBox(width: 3),

                            Flexible(
                              child: Text(

                                calories,

                                overflow:
                                    TextOverflow.ellipsis,

                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight:
                                      FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ================= PLAY BUTTON =================

                      Container(

                        height: 40,
                        width: 40,

                        decoration: const BoxDecoration(

                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF17C3B2),
                              Color(0xFF2EC4B6),
                            ],
                          ),

                          shape: BoxShape.circle,
                        ),

                        child: const Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 24,
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
    );
  }

  // ================= CHIP =================

  Widget infoChip(String text) {

    return Container(

      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),

      decoration: BoxDecoration(

        color: Colors.grey.shade100,

        borderRadius: BorderRadius.circular(18),
      ),

      child: Text(

        text,

        overflow: TextOverflow.ellipsis,

        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}