import 'package:flutter/material.dart';

class AiFloatingButton extends StatefulWidget {

  final VoidCallback onTap;

  const AiFloatingButton({
    super.key,
    required this.onTap,
  });

  @override
  State<AiFloatingButton> createState() =>
      _AiFloatingButtonState();
}

class _AiFloatingButtonState
    extends State<AiFloatingButton>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;

  @override
  void initState() {

    super.initState();

    controller = AnimationController(

      vsync: this,

      duration: const Duration(
        seconds: 2,
      ),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {

    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(

      animation: controller,

      builder: (context, child) {

        final scale =
            1 + (controller.value * 0.08);

        return Transform.scale(

          scale: scale,

          child: Container(

            height: 82,
            width: 82,

            decoration: BoxDecoration(

              shape: BoxShape.circle,

              gradient:
                  const LinearGradient(

                begin: Alignment.topLeft,
                end: Alignment.bottomRight,

                colors: [

                  Color(0xFFFFE082),
                  Color(0xFFFFB300),
                ],
              ),

              boxShadow: [

                BoxShadow(

                  color: const Color(
                    0xFFFFC107,
                  ).withValues(
                    alpha: 0.55,
                  ),

                  blurRadius: 35,

                  spreadRadius:
                      controller.value * 8,
                ),
              ],
            ),

            child: Material(

              color: Colors.transparent,

              child: InkWell(

                borderRadius:
                    BorderRadius.circular(
                  100,
                ),

                onTap: widget.onTap,

                child: const Column(

                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: [

                    Icon(

                      Icons.auto_awesome_rounded,

                      color: Colors.white,

                      size: 28,
                    ),

                    SizedBox(height: 2),

                    Text(

                      "AI",

                      style: TextStyle(

                        color: Colors.white,

                        fontSize: 11,

                        fontWeight:
                            FontWeight.bold,

                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}