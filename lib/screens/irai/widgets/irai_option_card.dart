import 'package:flutter/material.dart';

import '../models/irai_option.dart';

class IraiOptionCard extends StatelessWidget {
  final IraiOption option;

  final VoidCallback onTap;

  final bool selected;

  const IraiOptionCard({
    super.key,
    required this.option,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    const accentColor = Color(0xFF2FA7B2);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,

      margin: const EdgeInsets.only(bottom: 12),

      decoration: BoxDecoration(
        color: selected
            ? const Color(0xFFE8F8F7)
            : Colors.white,

        borderRadius: BorderRadius.circular(20),

        border: Border.all(
          color: selected
              ? accentColor
              : const Color(0xFFE8EAE8),

          width: selected ? 1.5 : 1,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Material(
        color: Colors.transparent,

        child: InkWell(
          onTap: onTap,

          borderRadius: BorderRadius.circular(20),

          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 17,
            ),

            child: Row(
              children: [

                //------------------------------------------------
                // EMOJI
                //------------------------------------------------

                Container(
                  width: 48,
                  height: 48,

                  decoration: BoxDecoration(
                    color: selected
                        ? Colors.white
                        : const Color(0xFFF6F7F3),

                    borderRadius:
                        BorderRadius.circular(15),
                  ),

                  alignment: Alignment.center,

                  child: Text(
                    option.emoji ?? "•",

                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                //------------------------------------------------
                // TEXT
                //------------------------------------------------

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Text(
                        option.title,

                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E2424),
                        ),
                      ),

                      if (option.subtitle != null) ...[
                        const SizedBox(height: 4),

                        Text(
                          option.subtitle!,

                          style: const TextStyle(
                            fontSize: 13,
                            height: 1.35,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(width: 10),

                //------------------------------------------------
                // ARROW / SELECTED STATE
                //------------------------------------------------

                AnimatedSwitcher(
                  duration:
                      const Duration(milliseconds: 180),

                  child: selected
                      ? const Icon(
                          Icons.check_circle_rounded,
                          key: ValueKey("selected"),
                          color: accentColor,
                          size: 25,
                        )
                      : const Icon(
                          Icons.arrow_forward_ios_rounded,
                          key: ValueKey("normal"),
                          color: Colors.grey,
                          size: 15,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}