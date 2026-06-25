import 'package:flutter/material.dart';

// ================= MODELS (Advanced Architecture) =================
class AdvancedDietModel {
  final String title;
  final String timeFrame;
  final String focusTag;
  final String description;
  final String emoji;
  final Color primaryColor;
  final List<String> foods;

  const AdvancedDietModel({
    required this.title,
    required this.timeFrame,
    required this.focusTag,
    required this.description,
    required this.emoji,
    required this.primaryColor,
    required this.foods,
  });
}

// ================= MOCK DATA (Strictly Veg & Vatham Balancing) =================
final List<AdvancedDietModel> advancedDietPlan = [
  const AdvancedDietModel(
    title: "Warm Hydration",
    timeFrame: "Morning & Between Meals",
    focusTag: "Soothing & Grounding",
    description: "Vata is naturally cold and dry. Sip warm liquids to build internal heat and improve digestion.",
    emoji: "☕",
    primaryColor: Color(0xFFD97706), // Warm Amber
    foods: ["Warm Ginger Water", "Cumin (Jeera) Tea", "Warm Lemon Water"],
  ),
  const AdvancedDietModel(
    title: "Grounding Breakfast",
    timeFrame: "07:30 - 09:00 AM",
    focusTag: "Warm & Nourishing",
    description: "Avoid cold or dry foods. Start the day with heavy, warm, and naturally sweet meals.",
    emoji: "🥣",
    primaryColor: Color(0xFFF59E0B), // Golden Yellow
    foods: ["Oatmeal with Ghee", "Stewed Apples/Pears", "Warm Almond Milk"],
  ),
  const AdvancedDietModel(
    title: "Hearty Lunch",
    timeFrame: "12:30 - 02:00 PM",
    focusTag: "Earth & Fire",
    description: "The main meal of the day. Focus on cooked grains, root vegetables, and healthy fats.",
    emoji: "🍛",
    primaryColor: Color(0xFF10B981), // Earthy Green
    foods: ["Basmati Rice", "Moong Dal with Ghee", "Sweet Potatoes"],
  ),
  const AdvancedDietModel(
    title: "Steamed Bowls", // Replaced 'Salads' because raw food aggravates Vata
    timeFrame: "Side Dishes",
    focusTag: "Cooked & Moist",
    description: "Strictly avoid raw, cold salads. Opt for thoroughly cooked or steamed vegetables dressed in oil.",
    emoji: "🍲",
    primaryColor: Color(0xFF84CC16), // Leaf Green
    foods: ["Steamed Carrots", "Cooked Beets", "Zucchini in Olive Oil"],
  ),
  const AdvancedDietModel(
    title: "Nourishing Snacks",
    timeFrame: "04:00 - 05:00 PM",
    focusTag: "Moist & Sweet",
    description: "Avoid dry, crunchy snacks (like crackers). Choose naturally sweet, hydrating, and grounding options.",
    emoji: "🌰",
    primaryColor: Color(0xFFEC4899), // Soft Pink
    foods: ["Soaked Almonds", "Fresh Dates", "Warm Spiced Milk"],
  ),
  const AdvancedDietModel(
    title: "Soothing Dinner",
    timeFrame: "07:00 - 08:30 PM",
    focusTag: "Easy Digestion",
    description: "A warm, soupy, and easily digestible meal to calm the nervous system for deep sleep.",
    emoji: "🌙",
    primaryColor: Color(0xFF6366F1), // Night Indigo
    foods: ["Thick Veg Soup", "Khichdi (Pongal)", "Mashed Pumpkin"],
  ),
];

// ================= MAIN PAGE =================
class AppetiteControlPage extends StatelessWidget {
  const AppetiteControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // Slate 50 - Very premium cool white
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          // --- Advanced Hero Header ---
          SliverAppBar(
            backgroundColor: const Color(0xFFF1F5F9),
            surfaceTintColor: Colors.transparent,
            pinned: true,
            expandedHeight: 160,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD97706).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "AYURVEDIC GUIDE",
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.2,
                            color: Color(0xFFD97706),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Vatham Balance",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F172A),
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- The Pro Cards List ---
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _ProDesignerCard(model: advancedDietPlan[index]);
                },
                childCount: advancedDietPlan.length,
              ),
            ),
          ),

          // --- Bottom Quote / Tip ---
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFD97706).withValues(alpha: 0.3), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD97706).withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("🌿", style: TextStyle(fontSize: 24)),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        "For a Vatham body type, food should be your medicine: always warm, well-cooked, and lightly spiced with healthy fats like Ghee.",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF92400E),
                          height: 1.5,
                        ),
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
  }
}

// ================= THE "PRO" CARD WIDGET =================
class _ProDesignerCard extends StatelessWidget {
  final AdvancedDietModel model;

  const _ProDesignerCard({required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32), // Extreme rounding for modern feel
        border: Border.all(color: Colors.white, width: 2), // Glossy edge
        boxShadow: [
          // Ambient soft shadow
          BoxShadow(
            color: const Color(0xFF94A3B8).withValues(alpha: 0.15),
            blurRadius: 30,
            spreadRadius: 0,
            offset: const Offset(0, 15),
          ),
          // Tight crisp shadow
          BoxShadow(
            color: const Color(0xFF94A3B8).withValues(alpha: 0.05),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: [
            // --- BACKGROUND LAYER: Massive Decorative Emoji ---
            Positioned(
              right: -30,
              top: -20,
              child: Transform.rotate(
                angle: 0.2, // Slight tilt
                child: Text(
                  model.emoji,
                  style: TextStyle(
                    fontSize: 140,
                    color: Colors.black.withValues(alpha: 0.03), // Barely visible texture
                  ),
                ),
              ),
            ),

            // --- FOREGROUND LAYER: Real Content ---
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Row: Time & Focus Tag
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Time indicator
                      Row(
                        children: [
                          Icon(Icons.schedule_rounded, size: 14, color: Colors.grey.shade400),
                          const SizedBox(width: 6),
                          Text(
                            model.timeFrame,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey.shade500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      // Vibrant Focus Tag
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: model.primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          model.focusTag,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: model.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Title Area
                  Row(
                    children: [
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: model.primaryColor.withValues(alpha: 0.05),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(model.emoji, style: const TextStyle(fontSize: 22)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          model.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                            letterSpacing: -0.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Subtitle/Description
                  Text(
                    model.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF475569),
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Divider(color: Color(0xFFF1F5F9), thickness: 1.5),
                  ),

                  // Smart Tags (Food Items)
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: model.foods.map((food) => _buildFoodChip(food, model.primaryColor)).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Pro Food Chip ---
  Widget _buildFoodChip(String label, Color themeColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFF1F5F9),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 6,
            width: 6,
            decoration: BoxDecoration(
              color: themeColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF334155),
            ),
          ),
        ],
      ),
    );
  }
}