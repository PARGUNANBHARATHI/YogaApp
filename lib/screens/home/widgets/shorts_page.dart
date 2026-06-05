import 'package:flutter/material.dart';

import '../../data/shorts_data.dart';
import 'widgets/short_video_player.dart';

class ShortsPage extends StatelessWidget {
  const ShortsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: PageView.builder(

        scrollDirection: Axis.vertical,

        itemCount: shorts.length,

        itemBuilder: (context, index) {

          final short = shorts[index];

          return Stack(

            fit: StackFit.expand,

            children: [

              // ================= VIDEO =================

              ShortVideoPlayer(
                videoUrl: short.videoUrl,
              ),

              // ================= OVERLAY =================

              Container(

                decoration: BoxDecoration(

                  gradient: LinearGradient(

                    begin: Alignment.topCenter,

                    end: Alignment.bottomCenter,

                    colors: [

                      Colors.transparent,

                      Colors.black.withValues(
                        alpha: 0.75,
                      ),
                    ],
                  ),
                ),
              ),

              // ================= CONTENT =================

              Positioned(

                left: 20,
                right: 90,
                bottom: 110,

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

                      child: Text(

                        short.title,

                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    Text(

                      short.quote,

                      style: const TextStyle(

                        color: Colors.white,

                        fontSize: 24,

                        height: 1.4,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // ================= ACTIONS =================

              Positioned(

                right: 16,
                bottom: 110,

                child: Column(

                  children: [

                    actionButton(
                      Icons.favorite_border,
                      "Save",
                    ),

                    const SizedBox(height: 18),

                    actionButton(
                      Icons.air,
                      "Breathe",
                    ),

                    const SizedBox(height: 18),

                    actionButton(
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

  Widget actionButton(
    IconData icon,
    String label,
  ) {
    return Column(

      children: [

        CircleAvatar(

          radius: 26,

          backgroundColor:
              Colors.white.withValues(
            alpha: 0.12,
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