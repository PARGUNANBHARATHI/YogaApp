import 'package:flutter/material.dart';

class PremiumHeroSection extends StatelessWidget {
  const PremiumHeroSection({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(

      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 18,
      ),

      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(28),

        gradient: const LinearGradient(

          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

          colors: [

            Color(0xFF0F172A),
            Color(0xFF111827),
          ],
        ),

        boxShadow: [

          BoxShadow(

            color: Colors.black.withValues(alpha: 0.08),

            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),

      child: Row(

        children: [

          // ================= LEFT =================

          Expanded(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(

                  "Welcome Back",

                  style: TextStyle(

                    color: Colors.white
                        .withValues(alpha: 0.65),

                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(

                  "IRAI",

                  style: TextStyle(

                    color: Colors.white,

                    fontSize: 30,

                    fontWeight: FontWeight.bold,

                    letterSpacing: -1,
                  ),
                ),

                const SizedBox(height: 12),

                Container(

                  padding:
                      const EdgeInsets.symmetric(

                    horizontal: 14,
                    vertical: 10,
                  ),

                  decoration: BoxDecoration(

                    borderRadius:
                        BorderRadius.circular(16),

                    color: Colors.white
                        .withValues(alpha: 0.08),
                  ),

                  child: Row(

                    mainAxisSize: MainAxisSize.min,

                    children: [

                      Container(

                        height: 10,
                        width: 10,

                        decoration: const BoxDecoration(

                          color: Color(0xFF18B7BE),

                          shape: BoxShape.circle,
                        ),
                      ),

                      const SizedBox(width: 10),

                      const Text(

                        "Mindfulness 82%",

                        style: TextStyle(

                          color: Colors.white,

                          fontWeight: FontWeight.w600,

                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ================= PROFILE =================

          Container(

            height: 60,
            width: 60,

            decoration: BoxDecoration(

              borderRadius:
                  BorderRadius.circular(20),

              border: Border.all(

                color: Colors.white
                    .withValues(alpha: 0.12),
              ),

              image: const DecorationImage(

                image: NetworkImage(
                  "https://images.unsplash.com/photo-1494790108377-be9c29b29330",
                ),

                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}