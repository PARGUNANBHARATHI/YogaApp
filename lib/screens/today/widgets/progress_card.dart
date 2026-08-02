import 'package:flutter/material.dart';

class ProgressCard extends StatelessWidget {
  final int total;

  const ProgressCard({
    super.key,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [

          //----------------------------------------
          // ICON
          //----------------------------------------

          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F8F7),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.spa_rounded,
              color: Color(0xFF2FA7B2),
              size: 34,
            ),
          ),

          const SizedBox(width: 18),

          //----------------------------------------
          // TEXT
          //----------------------------------------

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text(
                  "Today's Rhythm",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "$total Recommended Activities",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF2FA7B2),
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Your personalized wellness rhythm is ready for today.\nFollow the rhythm at your own pace.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}