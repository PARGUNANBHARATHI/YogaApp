import 'package:flutter/material.dart';

class TimelineHeader extends StatelessWidget {
  final String title;

  const TimelineHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 26,
        bottom: 14,
      ),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 24,
            decoration: BoxDecoration(
              color: const Color(0xFF16A34A),
              borderRadius:
                  BorderRadius.circular(10),
            ),
          ),

          const SizedBox(width: 12),

          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}