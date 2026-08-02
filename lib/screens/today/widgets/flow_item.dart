import 'package:flutter/material.dart';

class FlowItem extends StatelessWidget {
  final String time;
  final String title;
  final String subtitle;
  final String status;
  final IconData icon;
  final VoidCallback onTap;

  const FlowItem({
    super.key,
    required this.time,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.icon,
    required this.onTap,
  });

  bool get isNow => status.toLowerCase() == "now";

  Color get statusColor => const Color(0xFF16A34A);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: isNow
              ? Border.all(
                  color: statusColor,
                  width: 2,
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .04),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //----------------------------------------
            // TIME
            //----------------------------------------

            SizedBox(
              width: 78,
              child: Text(
                time,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            //----------------------------------------
            // ICON
            //----------------------------------------

            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isNow
                    ? statusColor.withValues(alpha: .12)
                    : const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                size: 28,
                color: isNow
                    ? statusColor
                    : Colors.grey.shade700,
              ),
            ),

            const SizedBox(width: 16),

            //----------------------------------------
            // CONTENT
            //----------------------------------------

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [

                      Expanded(
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow:
                              TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),

                      if (isNow)
                        Container(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor
                                .withValues(alpha: .12),
                            borderRadius:
                                BorderRadius.circular(
                                    20),
                          ),
                          child: Text(
                            "NOW",
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 11,
                              fontWeight:
                                  FontWeight.bold,
                              letterSpacing: .5,
                            ),
                          ),
                        ),

                      const SizedBox(width: 8),

                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                        color: Colors.grey,
                      ),

                    ],
                  ),

                  const SizedBox(height: 6),

                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}