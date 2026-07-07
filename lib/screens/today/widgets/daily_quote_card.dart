import 'package:flutter/material.dart';

class DailyQuoteCard extends StatelessWidget {
  final String quote;
  final String author;

  const DailyQuoteCard({
    super.key,
    required this.quote,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFBF8),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [

          const Text(
            "🌿",
            style: TextStyle(fontSize: 40),
          ),

          const SizedBox(height: 20),

          Text(
            quote,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              height: 1.5,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 18),

          Text(
            author,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 15,
            ),
          ),

        ],
      ),
    );
  }
}