import 'dart:ui';
import 'package:flutter/material.dart';

// உங்களுடைய ஃபைல் இம்போர்ட்கள் (Your existing imports)
import '../widgets/program_details_page.dart';
import 'food_manual_page.dart'; 
import 'appetite_control_page.dart';
import 'recovery_page.dart';

// ====== ADD THIS IMPORT FOR THE NEW YOGA SCREEN ======
// (Make sure the path matches where you saved the file from the previous step)
import 'ProYogaFeedScreen.dart'; 

class ProgramsPage extends StatelessWidget {
  const ProgramsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA), // Ultra clean background
      body: Stack(
        children: [
          // ================= 1. MESH GRADIENT BACKGROUND =================
          Positioned(
            top: -100,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF2FA7B2).withValues(alpha: 0.15), // Soft Teal
              ),
            ),
          ),
          Positioned(
            bottom: 200,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF8B5CF6).withValues(alpha: 0.1), // Soft Purple
              ),
            ),
          ),
          // Blur effect for the background
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
            child: Container(color: Colors.transparent),
          ),

          // ================= 2. MAIN CONTENT =================
          SafeArea(
            bottom: false,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // --- Premium Header ---
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Persionlized",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF64748B),
                                letterSpacing: 1.2,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Programs",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF0F172A),
                                letterSpacing: -1,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 52,
                          width: 52,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF2FA7B2).withValues(alpha: 0.15),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                            border: Border.all(color: const Color(0xFFF1F5F9), width: 2),
                          ),
                          child: const Icon(
                            Icons.workspace_premium_rounded,
                            color: Color(0xFF2FA7B2),
                            size: 26,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // --- Sections ---
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      buildSection(
                        title: "YOGA FOR Mind & Body",
                        subtitle: "Practices to balance energy and support unique needs.",
                        cards: const [
                           ProgramCard(title: "Guidelines", duration: "6 min", emoji: "🌸", themeColor: Color.fromARGB(255, 236, 72, 72)),
                          ProgramCard(title: "Yoga", duration: "15+ min", emoji: "🧘🏽", themeColor: Color(0xFFF59E0B)), // Updated emoji and duration
                          ProgramCard(title: "Mudra", duration: "6 min", emoji: "✨", themeColor: Color(0xFFEC4899)), // Fixed spelling & emoji
                           ProgramCard(title: "Meditation", duration: "6 min", emoji: "🌿", themeColor: Color(0xFF8B5CF6)), // Updated emoji & color
                        ],
                      ),
                      const SizedBox(height: 32),

                      buildSection(
                        title: "Food & Cravings",
                        subtitle: "Focused sessions to restore inner balance.",
                        cards: const [
                         
                          ProgramCard(title: "Food Management", duration: "7 min", emoji: "🕊️", themeColor: Color(0xFF8B5CF6)),
                           ProgramCard(title: "Grocery list", duration: "2 min", emoji: "🕊️", themeColor: Color(0xFF8B5CF6)),
                            ProgramCard(title: "Vegetable list", duration: "2 min", emoji: "🕊️", themeColor: Color(0xFF8B5CF6)),
                        ],
                      ),
                      const SizedBox(height: 32),

                      buildSection(
                        title: "HABITS & ROUTINES ",
                        subtitle: "Simple daily practices to stay calm and energized.",
                        cards: const [
                           ProgramCard(title: "Daily Flow", duration: "2 min", emoji: "🌱", themeColor: Color(0xFF10B981)),
                          ProgramCard(title: "Daily Habits", duration: "7 min", emoji: "🍏", themeColor: Color(0xFF2FA7B2)),
                          ProgramCard(title: "Stress Relief", duration: "4 min", emoji: "🌳", themeColor: Color(0xFF10B981)),
                          ProgramCard(title: "Freedom", duration: "5 min", emoji: "🦋", themeColor: Color(0xFF3B82F6)),
                        ],
                      ),
                      const SizedBox(height: 32),

                      buildSection(
                        title: "SELF-CARE & WELLNESS",
                        subtitle: "Design your own practices inspired by yoga.",
                        cards: const [
                          ProgramCard(title: "Weight Gain", duration: "5 min", emoji: "🥁", themeColor: Color(0xFFF59E0B)),
                          ProgramCard(title: "Weight Loss", duration: "6 min", emoji: "🧊", themeColor: Color(0xFF06B6D4)),
                          ProgramCard(title: "PCOD", duration: "3 min", emoji: "🐉", themeColor: Color(0xFFEF4444)),
                        ],
                      ),
                      const SizedBox(height: 40), // Bottom padding
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSection({
    required String title,
    required String subtitle,
    required List<Widget> cards,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1E293B),
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cards.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16, 
            mainAxisSpacing: 16,
            mainAxisExtent: 175, 
          ),
          itemBuilder: (context, index) {
            return cards[index];
          },
        ),
      ],
    );
  }
}

// ================= PREMIUM CARD UI =================
class ProgramCard extends StatelessWidget {
  final String title;
  final String duration;
  final String emoji;
  final Color themeColor;

  const ProgramCard({
    super.key,
    required this.title,
    required this.duration,
    required this.emoji,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // ================= UPDATED NAVIGATION LOGIC =================
        if (title == "Yoga") {
          // Routes to the new Premium Video Feed we created!
          Navigator.push(context, MaterialPageRoute(builder: (_) => const ProYogaFeedScreen()));
        } else if (title == "Daily Flow") {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const DailyFlowPage()));
        } else if (title == "Daily Habits") {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const VathamRoutinePage()));
        } else if (title == "Food Management") {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const RecoveryPage()));
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProgramDetailsPage(title: title, duration: duration),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.7), 
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.white, width: 2), 
          boxShadow: [
            BoxShadow(
              color: themeColor.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(26),
          child: Stack(
            children: [
              // --- Subtle Inner Glow ---
              Positioned(
                top: -20,
                right: -20,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: themeColor.withValues(alpha: 0.15),
                  ),
                ),
              ),

              // --- Content ---
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Glowing Emoji Container
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: themeColor.withValues(alpha: 0.2),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(emoji, style: const TextStyle(fontSize: 24)),
                      ),
                    ),
                    const Spacer(),

                    // Title
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                        height: 1.2,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Bottom Row: Duration & Play Icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Premium Duration Pill
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: themeColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: themeColor.withValues(alpha: 0.2), width: 1),
                          ),
                          child: Text(
                            duration,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: themeColor,
                            ),
                          ),
                        ),
                        // Sleek Play/Forward Button
                        Container(
                          height: 28,
                          width: 28,
                          decoration: BoxDecoration(
                            color: themeColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 16,
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