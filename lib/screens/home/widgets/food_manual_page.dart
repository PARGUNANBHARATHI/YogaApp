import 'package:flutter/material.dart';

// ================= MODELS (The Smart Way) =================
class DailyRoutine {
  final String time;
  final String title;
  final String description;
  final IconData icon;
  final List<Color> gradient;
  final List<String> goodFoods;
  final List<String>? avoidFoods;

  const DailyRoutine({
    required this.time,
    required this.title,
    required this.description,
    required this.icon,
    required this.gradient,
    required this.goodFoods,
    this.avoidFoods,
  });
}

// ================= MOCK DATA (Chronological Flow) =================
final List<DailyRoutine> dailyFlow = [
  const DailyRoutine(
    time: "06:00 AM - 07:00 AM",
    title: "Wake Up & Hydrate",
    description: "Start your day by flushing toxins and waking up your digestive system.",
    icon: Icons.water_drop_rounded,
    gradient: [Color(0xFF38BDF8), Color(0xFF0284C7)], // Fresh Morning Blue
    goodFoods: ["Warm Water", "Cumin (Seeragam) Water"],
    avoidFoods: ["Cold Water", "Coffee immediately"],
  ),
  const DailyRoutine(
    time: "08:30 AM - 09:30 AM",
    title: "Morning Breakfast",
    description: "Warm, easy-to-digest foods to build steady energy.",
    icon: Icons.wb_twilight_rounded,
    gradient: [Color(0xFFFBBF24), Color(0xFFEA580C)], // Sunrise Orange/Yellow
    goodFoods: ["Ven Pongal", "Idli / Dosa", "Wheat Dosa", "Moong Dal"],
    avoidFoods: ["Heavy oily foods"],
  ),
  const DailyRoutine(
    time: "11:00 AM - 11:30 AM",
    title: "Mid-Morning Beverage",
    description: "Traditional teas to keep the metabolism active.",
    icon: Icons.emoji_food_beverage_rounded,
    gradient: [Color(0xFF34D399), Color(0xFF059669)], // Herbal Green
    goodFoods: ["Ginger Tea", "Garlic Tea", "Garlic Milk"],
  ),
  const DailyRoutine(
    time: "01:00 PM - 02:00 PM",
    title: "Nourishing Lunch",
    description: "The largest meal of the day when digestion is strongest.",
    icon: Icons.light_mode_rounded,
    gradient: [Color(0xFFFACC15), Color(0xFFCA8A04)], // Midday Sun
    goodFoods: ["Raw Rice", "Moong Dal Sambar", "Veg Kootu", "Keerai Masiyal"],
    avoidFoods: ["Toor Dal (துவரம்பருப்பு)"],
  ),
  const DailyRoutine(
    time: "05:00 PM - 06:00 PM",
    title: "Evening Snacks",
    description: "Light, warm snacks to curb cravings without ruining dinner.",
    icon: Icons.nightlight_round,
    gradient: [Color(0xFFA78BFA), Color(0xFF7C3AED)], // Twilight Purple
    goodFoods: ["Sundal (Chickpeas)", "Warm Veg Soup"],
    avoidFoods: ["Bajji", "Vada", "Soft Drinks"],
  ),
  const DailyRoutine(
    time: "08:00 PM - 09:00 PM",
    title: "Light Dinner",
    description: "Keep it extremely light to ensure deep, restorative sleep.",
    icon: Icons.bedtime_rounded,
    gradient: [Color(0xFF64748B), Color(0xFF334155)], // Night Slate
    goodFoods: ["Idli", "Chapathi", "Warm Milk"],
    avoidFoods: ["Heavy meals", "Late eating"],
  ),
];

// ================= MAIN PAGE =================
class DailyFlowPage extends StatelessWidget {
  const DailyFlowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // --- Premium App Bar ---
          SliverAppBar(
            backgroundColor: const Color(0xFFF8F9FA),
            surfaceTintColor: Colors.transparent,
            pinned: true,
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              title: const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Daily Flow",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Traditional wisdom for modern rhythm",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- Timeline List ---
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final isLast = index == dailyFlow.length - 1;
                  return _buildTimelineItem(dailyFlow[index], isLast);
                },
                childCount: dailyFlow.length,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  // ================= TIMELINE WIDGET =================
  Widget _buildTimelineItem(DailyRoutine routine, bool isLast) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // --- Left Side: Timeline Line & Node ---
          SizedBox(
            width: 40,
            child: Column(
              children: [
                // Icon Node
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: routine.gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                       color: routine.gradient.first.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    routine.icon,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                // Connecting Line (Hidden for the last item)
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // --- Right Side: Content Card ---
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey.shade100, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Time Badge
                    Text(
                      routine.time,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: routine.gradient.last,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Title
                    Text(
                      routine.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Description
                    Text(
                      routine.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF64748B),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Good Foods (Pills)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: routine.goodFoods
                          .map((food) => _buildFoodChip(food, true))
                          .toList(),
                    ),

                    // Avoid Foods (Pills)
                    if (routine.avoidFoods != null && routine.avoidFoods!.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      const Text(
                        "Avoid:",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: routine.avoidFoods!
                            .map((food) => _buildFoodChip(food, false))
                            .toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= MODERN FOOD CHIP =================
  Widget _buildFoodChip(String label, bool isGood) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isGood ? const Color(0xFFF0FDF4) : const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isGood ? const Color(0xFFBBF7D0) : const Color(0xFFFECACA),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isGood ? Icons.check_circle_rounded : Icons.cancel_rounded,
            size: 14,
            color: isGood ? const Color(0xFF16A34A) : const Color(0xFFDC2626),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isGood ? const Color(0xFF15803D) : const Color(0xFFB91C1C),
            ),
          ),
        ],
      ),
    );
  }
}