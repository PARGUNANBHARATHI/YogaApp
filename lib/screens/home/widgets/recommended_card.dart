import 'package:flutter/material.dart';

class RecommendedCard extends StatelessWidget {

  final String title;
  final String subtitle;
  final String image;

  const RecommendedCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      
      width: 320,
  
      margin: const EdgeInsets.only(
        right: 15,
      ),

      decoration: BoxDecoration(

        color: const Color(0xFFFDFBF7),

        borderRadius:
            BorderRadius.circular(20),

        boxShadow: [

          BoxShadow(

            color:
                const Color.fromARGB(255, 0, 0, 0).withValues(
              alpha: 0.045,
            ),

            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          // ================= IMAGE =================

          ClipRRect(

            borderRadius:
                const BorderRadius.vertical(
              top: Radius.circular(20),
            ),

            child: Stack(

              children: [

                Image.network(

                  image,

                  height: 220,
                  width: double.infinity,

                  fit: BoxFit.cover,
                ),

                // ================= CATEGORY CHIP =================

                Positioned(

                  left: 15,
                  bottom: 15,

                  child: Container(

                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),

                    decoration: BoxDecoration(

                      color: Colors.white,

                      borderRadius:
                          BorderRadius.circular(15),
                    ),

                    child: const Row(

                      mainAxisSize:
                          MainAxisSize.min,

                      children: [

                        Icon(
                          Icons.self_improvement,
                          size: 16,
                          color: Color(0xFF2FA7B2),
                        ),

                        SizedBox(width: 6),

                        Text(

                          "Meditation",

                          style: TextStyle(

                            fontSize: 13,

                            fontWeight:
                                FontWeight.w600,

                            color:
                                Color(0xFF2B2927),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ================= CONTENT =================

          Expanded(

            child: Padding(

              padding: const EdgeInsets.all(16),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  // ================= TOP =================

                  Row(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      // ================= TEXT =================

                      Expanded(

                        child: Column(

                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            Text(

                              title,

                              maxLines: 1,

                              overflow:
                                  TextOverflow.ellipsis,

                              style: const TextStyle(

                                fontSize: 20,

                                fontWeight:
                                    FontWeight.bold,

                                color:
                                    Color(0xFF2B2927),

                                letterSpacing: -0.5,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(

                              subtitle,

                              maxLines: 2,

                              overflow:
                                  TextOverflow.ellipsis,

                              style: const TextStyle(

                                fontSize: 13,

                                height: 1.4,

                                color:
                                    Color(0xFF7A746B),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 12),

                      // ================= TIME CARD =================

                      Container(

                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),

                        decoration: BoxDecoration(

                          color:
                              const Color(0xFFF5F1EA),

                          borderRadius:
                              BorderRadius.circular(
                            18,
                          ),
                        ),

                        child: const Column(

                          children: [

                            Text(

                              "14",

                              style: TextStyle(

                                fontSize: 20,

                                fontWeight:
                                    FontWeight.bold,

                                color:
                                    Color(0xFF2B2927),
                              ),
                            ),

                            SizedBox(height: 1),

                            Text(

                              "min",

                              style: TextStyle(

                                fontSize: 12,

                                fontWeight:
                                    FontWeight.w600,

                                color:
                                    Color(0xFF7A746B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // ================= BUTTON =================

                  SizedBox(

                    width: double.infinity,
                    height: 45,

                    child: ElevatedButton(

                      onPressed: () {},

                      style:
                          ElevatedButton.styleFrom(

                        backgroundColor:
                            const Color(
                          0xFF2FA7B2,
                        ),

                        foregroundColor:
                            Colors.white,

                        elevation: 0,

                        shape:
                            RoundedRectangleBorder(

                          borderRadius:
                              BorderRadius.circular(
                            18,
                          ),
                        ),
                      ),

                      child: const Text(

                        "Explore",

                        style: TextStyle(

                          fontSize: 16,

                          fontWeight:
                              FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}