import 'package:flutter/material.dart';

class ProgressCard extends StatelessWidget {
  final int completed;
  final int total;

  const ProgressCard({
    super.key,
    required this.completed,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final double progress =
        total == 0 ? 0 : completed / total;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //----------------------------------------
          // TITLE
          //----------------------------------------

          const Text(
            "Today's Progress",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "Every small step builds a healthier life.",
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 28),

          //----------------------------------------
          // PERCENTAGE
          //----------------------------------------

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [

              Text(
                "${(progress * 100).round()}%",
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),

              const SizedBox(width: 10),

              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  "$completed of $total completed",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 15,
                  ),
                ),
              ),

            ],
          ),

          const SizedBox(height: 24),

          //----------------------------------------
          // PROGRESS BAR
          //----------------------------------------

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation(
                Color(0xFF22C55E),
              ),
            ),
          ),

          const SizedBox(height: 24),

          //----------------------------------------
          // STATS
          //----------------------------------------

          Row(
            children: [

              Expanded(
                child: _infoCard(
                  Icons.check_circle,
                  "Completed",
                  completed.toString(),
                  const Color(0xFF22C55E),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _infoCard(
                  Icons.schedule,
                  "Remaining",
                  (total - completed).toString(),
                  Colors.orange,
                ),
              ),

            ],
          ),

          const SizedBox(height: 24),

          //----------------------------------------
          // MOTIVATION
          //----------------------------------------

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F8F4),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [

                const Text(
                  "🌿",
                  style: TextStyle(fontSize: 24),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    completed == total
                        ? "Excellent! You completed today's wellness journey."
                        : "Keep going. You're making steady progress today.",
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget _infoCard(
    IconData icon,
    String title,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 14,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(.10),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [

          Icon(
            icon,
            color: color,
          ),

          const SizedBox(height: 8),

          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 13,
            ),
          ),

        ],
      ),
    );
  }
}