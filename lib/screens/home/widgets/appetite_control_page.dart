import 'dart:ui';
import 'package:flutter/material.dart';

// ================= MODELS =================
class SiddhaRoutineModel {
  final String title;
  final String timeFrame;
  final String focusTag;
  final String description;
  final String emoji;
  final Color primaryColor;
  final List<String> habits;

  const SiddhaRoutineModel({
    required this.title,
    required this.timeFrame,
    required this.focusTag,
    required this.description,
    required this.emoji,
    required this.primaryColor,
    required this.habits,
  });
}

class DailyFlowStep {
  final String time;
  final String title;
  final String description;
  final String emoji;
  final Color color;

  const DailyFlowStep({
    required this.time,
    required this.title,
    required this.description,
    required this.emoji,
    required this.color,
  });
}

// ================= MOCK DATA =================
final List<SiddhaRoutineModel> vathamRoutinePlan = [
  const SiddhaRoutineModel(
    title: "Daily Habits",
    timeFrame: "Sunrise to Sleep",
    focusTag: "Foundation",
    description: "Strict consistency is key. Wake up early, perform mild exercises, and ensure deep, uninterrupted sleep.",
    emoji: "🌅",
    primaryColor: Color(0xFFF59E0B), // Golden Amber
    habits: ["Brahma Muhurtham", "Mild Yoga", "Sleep by 9:30 PM"],
  ),
  const SiddhaRoutineModel(
    title: "Weekly Care",
    timeFrame: "1 or 2 Times / Week",
    focusTag: "Restoration",
    description: "Soothe the nervous system and prevent bodily dryness with traditional warm oil baths.",
    emoji: "🌿",
    primaryColor: Color(0xFF10B981), // Healing Green
    habits: ["Warm Sesame Oil Bath", "Digital Detox"],
  ),
  const SiddhaRoutineModel(
    title: "Monthly Detox",
    timeFrame: "Once a Month",
    focusTag: "Deep Cleanse",
    description: "Clear accumulated Vatham from the colon through mild purgation and indulge in a full-body massage.",
    emoji: "💆‍♀️",
    primaryColor: Color(0xFF8B5CF6), // Deep Purple
    habits: ["Mild Purgation", "Full Body Massage"],
  ),
];

final List<DailyFlowStep> vathamDailyFlow = [
  const DailyFlowStep(
    time: "04:30 AM",
    title: "Brahma Muhurtham",
    description: "Wake up naturally. Drink 1-2 glasses of warm water to stimulate digestion and clear Vatham.",
    emoji: "🌅",
    color: Color(0xFFF59E0B),
  ),
  const DailyFlowStep(
    time: "05:00 AM",
    title: "Morning Cleanse",
    description: "Ensure bowel clearance. Perform oil pulling with warm sesame oil to prevent oral dryness.",
    emoji: "🚰",
    color: Color(0xFF3B82F6),
  ),
  const DailyFlowStep(
    time: "06:00 AM",
    title: "Grounding Movement",
    description: "Mild joint rotations, Pawanmuktasana, and Nadi Shodhana Pranayama to calm the nervous system.",
    emoji: "🧘‍♂️",
    color: Color(0xFF10B981),
  ),
  const DailyFlowStep(
    time: "08:00 AM",
    title: "Nourishment",
    description: "Consume a warm, grounding breakfast with healthy fats (like Ghee). Strictly avoid cold or raw food.",
    emoji: "🥣",
    color: Color(0xFFEAB308),
  ),
  const DailyFlowStep(
    time: "05:00 PM",
    title: "Wind Down",
    description: "Take a mild evening walk. Disconnect from intense work to prevent Vatham-induced anxiety.",
    emoji: "🚶",
    color: Color(0xFF8B5CF6),
  ),
  const DailyFlowStep(
    time: "09:30 PM",
    title: "Deep Rest",
    description: "Massage soles of the feet with warm oil. Drink warm spiced milk and sleep peacefully.",
    emoji: "🌙",
    color: Color(0xFF6366F1),
  ),
];

// ================= MAIN PAGE =================
class VathamRoutinePage extends StatelessWidget {
  const VathamRoutinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Stack(
        children: [
          // Background Mesh
          Positioned(
            top: -100, left: -100,
            child: Container(width: 300, height: 300, decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFFF59E0B).withValues(alpha: 0.15))),
          ),
          Positioned(
            top: 200, right: -150,
            child: Container(width: 400, height: 400, decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFF8B5CF6).withValues(alpha: 0.1))),
          ),
          BackdropFilter(filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80), child: Container(color: Colors.transparent)),

          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white.withValues(alpha: 0.5),
                surfaceTintColor: Colors.transparent,
                pinned: true,
                expandedHeight: 180,
                flexibleSpace: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: FlexibleSpaceBar(
                      titlePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20)),
                            child: const Text("PREMIUM PLAN", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w800, letterSpacing: 1.5, color: Colors.white)),
                          ),
                          const SizedBox(height: 6),
                          const Text("Vatham Mastery", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), letterSpacing: -1)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(top: 20, bottom: 40),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _AdvancedRoutineCard(model: vathamRoutinePlan[index], index: index),
                    childCount: vathamRoutinePlan.length,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

   // ================= THE "ULTRA PREMIUM" CARD =================
class _AdvancedRoutineCard extends StatelessWidget {
  final SiddhaRoutineModel model;
  final int index;

  const _AdvancedRoutineCard({required this.model, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: GestureDetector(
        onTap: () {
          // முதல் கார்டை (Daily Habits) க்ளிக் செய்தால் மட்டும் அடுத்த பக்கம் போகும்
          if (index == 0) {
            Navigator.push(
              context, 
              // நீங்கள் திருத்திய "DailyFlowsPage" என்ற பெயர் இங்கு பயன்படுத்தப்பட்டுள்ளது
              MaterialPageRoute(builder: (context) => const DailyFlowsPage()) 
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(color: model.primaryColor.withValues(alpha: 0.08), blurRadius: 24, offset: const Offset(0, 10)),
              BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4)),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Stack(
              children: [
                Positioned(
                  right: -40, top: -40,
                  child: Container(
                    width: 150, height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(colors: [model.primaryColor.withValues(alpha: 0.2), Colors.transparent]),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("0${index + 1}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.grey.shade400)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(color: model.primaryColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
                            child: Text(model.focusTag.toUpperCase(), style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: model.primaryColor, letterSpacing: 1.0)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Text(model.emoji, style: const TextStyle(fontSize: 32)),
                          const SizedBox(width: 16),
                          Expanded(child: Text(model.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF0F172A), letterSpacing: -0.5))),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(model.description, style: const TextStyle(fontSize: 14, color: Color(0xFF64748B), height: 1.6, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 24),
                      Wrap(
                        spacing: 8, runSpacing: 8,
                        children: model.habits.map((h) => _buildModernChip(h, model.primaryColor)).toList(),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("TIMEFRAME", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.grey.shade400, letterSpacing: 1.0)),
                              const SizedBox(height: 4),
                              Text(model.timeFrame, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF334155))),
                            ],
                          ),
                          Container(
                            height: 48, width: 48,
                            decoration: BoxDecoration(
                              color: model.primaryColor,
                              shape: BoxShape.circle,
                              boxShadow: [BoxShadow(color: model.primaryColor.withValues(alpha: 0.4), blurRadius: 12, offset: const Offset(0, 4))],
                            ),
                            child: const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
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
      ),
    );
  }

  Widget _buildModernChip(String label, Color themeColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle_rounded, size: 14, color: themeColor),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
        ],
      ),
    );
  }
}
// ================= NEW: DAILY FLOW TIMELINE PAGE =================
class DailyFlowsPage extends StatelessWidget {
  const DailyFlowsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF0F172A), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Daily Flow",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        physics: const BouncingScrollPhysics(),
        itemCount: vathamDailyFlow.length,
        itemBuilder: (context, index) {
          final step = vathamDailyFlow[index];
          final isLast = index == vathamDailyFlow.length - 1;

          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Time Column
                SizedBox(
                  width: 65,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      step.time,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey.shade500,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ),

                // 2. Timeline Indicator (Node & Line)
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 12),
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        color: step.color.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                        border: Border.all(color: step.color, width: 2),
                      ),
                      child: Center(
                        child: Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(color: step.color, shape: BoxShape.circle),
                        ),
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2,
                          color: step.color.withValues(alpha: 0.2),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 16),

                // 3. Content Card
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: const Color(0xFFF1F5F9), width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(step.emoji, style: const TextStyle(fontSize: 20)),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  step.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF0F172A),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            step.description,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF64748B),
                              height: 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}