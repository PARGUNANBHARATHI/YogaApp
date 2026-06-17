import 'package:flutter/material.dart';

class ShortsPage extends StatelessWidget {
  const ShortsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: PageView.builder(
        scrollDirection: Axis.vertical,

        itemCount: 5,

        itemBuilder: (context, index) {
          return Stack(

            fit: StackFit.expand,

            children: [

              Container(
                color: Colors.black87,
              ),

              Container(

                decoration: BoxDecoration(

                  gradient: LinearGradient(

                    begin: Alignment.topCenter,

                    end: Alignment.bottomCenter,

                    colors: [

                      Colors.transparent,

                      Colors.black.withValues(
                        alpha: 0.8,
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(

                left: 20,
                right: 20,
                bottom: 120,

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Container(

                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),

                      decoration: BoxDecoration(

                        color:
                            const Color(0xFF2FA7B2),

                        borderRadius:
                            BorderRadius.circular(
                          20,
                        ),
                      ),

                      child: const Text(

                        "Daily Wisdom",

                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Text(

                      "The quality of your life depends on how you experience life.",

                      style: TextStyle(

                        color: Colors.white,

                        fontSize: 24,

                        fontWeight:
                            FontWeight.bold,

                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              Positioned(

                right: 16,
                bottom: 120,

                child: Column(

                  children: [

                    _actionButton(
                      Icons.favorite_border,
                      "Save",
                    ),

                    const SizedBox(height: 20),

                    _actionButton(
                      Icons.air,
                      "Breathe",
                    ),

                    const SizedBox(height: 20),

                    _actionButton(
                      Icons.share,
                      "Share",
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _actionButton(
    IconData icon,
    String label,
  ) {

    return Column(

      children: [

        CircleAvatar(

          radius: 26,

          backgroundColor:
              Colors.white.withValues(
            alpha: 0.15,
          ),

          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 6),

        Text(

          label,

          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}