import 'package:flutter/material.dart';

class YourMomentCard extends StatelessWidget {
  final String title;
  final String focus;
  final String duration;
  final String image;
  final VoidCallback onTap;

  const YourMomentCard({
    super.key,
    required this.title,
    required this.focus,
    required this.duration,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.08),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Stack(
            children: [

              //--------------------------------------------------
              // IMAGE
              //--------------------------------------------------

              SizedBox(
                height: 340,
                width: double.infinity,
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  loadingBuilder:
                      (context, child, progress) {
                    if (progress == null) return child;

                    return Container(
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                  errorBuilder:
                      (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: const Icon(
                        Icons.image,
                        size: 60,
                      ),
                    );
                  },
                ),
              ),

              //--------------------------------------------------
              // DARK OVERLAY
              //--------------------------------------------------

              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(.65),
                      ],
                    ),
                  ),
                ),
              ),

              //--------------------------------------------------
              // NOW BADGE
              //--------------------------------------------------

              Positioned(
                top: 22,
                left: 22,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.20),
                    borderRadius:
                        BorderRadius.circular(30),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      Icon(
                        Icons.circle,
                        color: Colors.greenAccent,
                        size: 10,
                      ),

                      SizedBox(width: 8),

                      Text(
                        "NOW",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),

                    ],
                  ),
                ),
              ),

              //--------------------------------------------------
              // DURATION
              //--------------------------------------------------

              Positioned(
                top: 22,
                right: 22,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.35),
                    borderRadius:
                        BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [

                      const Icon(
                        Icons.schedule,
                        color: Colors.white,
                        size: 16,
                      ),

                      const SizedBox(width: 6),

                      Text(
                        duration,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    ],
                  ),
                ),
              ),

              //--------------------------------------------------
              // CONTENT
              //--------------------------------------------------

              Positioned(
                left: 24,
                right: 24,
                bottom: 24,
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        height: 1.1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      focus,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 17,
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 24),

                    Row(
                      children: [

                        const Icon(
                          Icons.play_circle_fill,
                          color: Colors.white,
                          size: 24,
                        ),

                        const SizedBox(width: 10),

                        const Text(
                          "Begin Session",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),

                        const Spacer(),

                        Container(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            size: 18,
                          ),
                        ),

                      ],
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}