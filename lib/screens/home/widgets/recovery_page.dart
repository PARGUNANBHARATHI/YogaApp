import 'package:flutter/material.dart';

// ================= MODELS =================
class RecoveryMeal {
  final String title;
  final String description;
  final String imageUrl;
  final String prepTime;
  final String calories;
  final String primaryTag;
  final bool isVeg;

  const RecoveryMeal({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.prepTime,
    required this.calories,
    required this.primaryTag,
    this.isVeg = true,
  });
}

// ================= MOCK DATA =================
final Map<String, List<RecoveryMeal>> recoveryMenu = {
  "🌅 Morning Healing": [
    const RecoveryMeal(
      title: "Turmeric Oats",
      description: "Warm, anti-inflammatory oats with fresh berries.",
      imageUrl: "https://images.unsplash.com/photo-1517673132405-a56a62b18caf?q=80&w=640&auto=format&fit=crop",
      prepTime: "10 min",
      calories: "320 kcal",
      primaryTag: "Anti-inflammatory",
    ),
    const RecoveryMeal(
      title: "Avocado Toast",
      description: "Whole grain toast packed with healthy fats.",
      imageUrl: "https://images.unsplash.com/photo-1541519227354-08fa5d50c44d?q=80&w=640&auto=format&fit=crop",
      prepTime: "5 min",
      calories: "280 kcal",
      primaryTag: "Iron Rich",
    ),
    const RecoveryMeal(
      title: "Green Smoothie",
      description: "Detoxing spinach, apple, and ginger blend.",
      imageUrl: "https://images.unsplash.com/photo-1610832958506-aa56368176cf?q=80&w=640&auto=format&fit=crop",
      prepTime: "3 min",
      calories: "180 kcal",
      primaryTag: "Detox",
    ),
    const RecoveryMeal(
      title: "Chia Pudding",
      description: "Omega-3 rich pudding for joint recovery.",
      imageUrl: "https://images.unsplash.com/photo-1556881286-fc6915169721?q=80&w=640&auto=format&fit=crop",
      prepTime: "2 min",
      calories: "210 kcal",
      primaryTag: "Omega-3",
    ),
  ],
  "🌇 Evening Nourishment": [
    const RecoveryMeal(
      title: "Citrus Salad",
      description: "Light greens, oranges, and walnuts.",
      imageUrl: "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?q=80&w=640&auto=format&fit=crop",
      prepTime: "15 min",
      calories: "210 kcal",
      primaryTag: "Vitamin C",
    ),
    const RecoveryMeal(
      title: "Mushroom Soup",
      description: "Warm, earthy, and immune-boosting clear soup.",
      imageUrl: "https://images.unsplash.com/photo-1548943487-a2e4b43b485f?q=80&w=640&auto=format&fit=crop",
      prepTime: "20 min",
      calories: "150 kcal",
      primaryTag: "Immunity",
    ),
    const RecoveryMeal(
      title: "Roasted Snacks",
      description: "Crunchy, light roasted seeds with mild spices.",
      imageUrl: "https://images.unsplash.com/photo-1606756790138-261d2b21caa7?q=80&w=640&auto=format&fit=crop",
      prepTime: "5 min",
      calories: "110 kcal",
      primaryTag: "Low Calorie",
    ),
  ],
  "🌙 Restorative Dinner": [
    const RecoveryMeal(
      title: "Quinoa Veg Stew",
      description: "Thick, comforting, easily digestible stew.",
      imageUrl: "https://images.unsplash.com/photo-1547592180-85f173990554?q=80&w=640&auto=format&fit=crop",
      prepTime: "25 min",
      calories: "380 kcal",
      primaryTag: "Protein",
    ),
    const RecoveryMeal(
      title: "Steamed Veggies",
      description: "Broccoli and carrots with a dash of olive oil.",
      imageUrl: "https://images.unsplash.com/photo-1466637574441-749b8f19452f?q=80&w=640&auto=format&fit=crop",
      prepTime: "15 min",
      calories: "120 kcal",
      primaryTag: "Digestion",
    ),
  ],
};

// ================= MAIN RECOVERY PAGE =================
class RecoveryPage extends StatelessWidget {
  const RecoveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // --- Premium Hero Header ---
          SliverAppBar(
            backgroundColor: const Color(0xFFF8F9FA),
            surfaceTintColor: Colors.transparent,
            pinned: true,
            expandedHeight: 120, // Minimized Header
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              title: const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recovery Menu",
                    style: TextStyle(
                      fontSize: 24, // Slightly smaller title
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0F172A),
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "Healing portions. Smart choices.",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF16A34A),
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- HORIZONTAL CAROUSEL SECTIONS ---
          ...recoveryMenu.entries.map((entry) {
            String category = entry.key;
            List<RecoveryMeal> meals = entry.value;

            return SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- HEADER WITH "SEE ALL" BUTTON ---
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          category,
                          style: const TextStyle(
                            fontSize: 18, // Minimized section title
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1E293B),
                            letterSpacing: -0.3,
                          ),
                        ),
                        
                        InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SeeAllMealsPage(
                                  categoryName: category,
                                  meals: meals,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Row(
                              children: [
                                Text(
                                  "See all",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF16A34A).withValues(alpha: 0.9),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 10,
                                  color: const Color(0xFF16A34A).withValues(alpha: 0.9),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // --- HORIZONTAL SCROLLING LIST ---
                  SizedBox(
                    height: 230, // STRONGLY MINIMIZED CAROUSEL HEIGHT
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: meals.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 14),
                      itemBuilder: (context, index) {
                        return _PremiumMealCard(
                          meal: meals[index],
                          width: 160, // STRONGLY MINIMIZED CARD WIDTH
                        );
                      },
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                ],
              ),
            );
          }),

          const SliverToBoxAdapter(child: SizedBox(height: 60)),
        ],
      ),
    );
  }
}

// ================= "SEE ALL" CATEGORY PAGE (FULL GRID) =================
class SeeAllMealsPage extends StatelessWidget {
  final String categoryName;
  final List<RecoveryMeal> meals;

  const SeeAllMealsPage({
    super.key,
    required this.categoryName,
    required this.meals,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(
          categoryName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
            letterSpacing: -0.3,
          ),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20), // Tighter padding for grid
        physics: const BouncingScrollPhysics(),
        itemCount: meals.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, 
          mainAxisSpacing: 16, // Tighter spacing
          crossAxisSpacing: 16,
          mainAxisExtent: 230, // MATCHES HORIZONTAL CARD HEIGHT
        ),
        itemBuilder: (context, index) {
          return _PremiumMealCard(meal: meals[index]); 
        },
      ),
    );
  }
}

// ================= MINIMIZED PREMIUM CARD =================
class _PremiumMealCard extends StatelessWidget {
  final RecoveryMeal meal;
  final double? width;

  const _PremiumMealCard({
    required this.meal,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18), // Tighter radius for smaller card
        border: Border.all(color: Colors.grey.shade100, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF94A3B8).withValues(alpha: 0.08),
            blurRadius: 15, // Softer shadow for compact size
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- IMAGE LAYER ---
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  meal.imageUrl,
                  height: 100, // MINIMIZED IMAGE HEIGHT
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 100,
                    width: double.infinity,
                    color: const Color(0xFFF1F5F9),
                    child: const Icon(Icons.restaurant, color: Color(0xFF94A3B8)),
                  ),
                ),
              ),
              
              // Gradient Overlay
              Positioned(
                bottom: 0, left: 0, right: 0,
                height: 35,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              
              // Prep Time 
              Positioned(
                bottom: 8, left: 8,
                child: Row(
                  children: [
                    const Icon(Icons.access_time_rounded, size: 12, color: Colors.white),
                    const SizedBox(width: 4),
                    Text(
                      meal.prepTime,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10, // Minimized text
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),

              // Veg Icon
              if (meal.isVeg)
                Positioned(
                  top: 8, right: 8,
                  child: Container(
                    height: 16, width: 16, // Minimized Veg icon
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: const Color(0xFF16A34A), width: 1.5),
                    ),
                    child: Center(
                      child: Container(
                        height: 6, width: 6,
                        decoration: const BoxDecoration(
                          color: Color(0xFF16A34A),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),

          // --- DETAILS LAYER ---
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12), // Tighter inner padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    meal.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14, // Scaled down title
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                      letterSpacing: -0.2,
                    ),
                  ),
                  
                  const SizedBox(height: 4),
                  
                  // Description
                  Text(
                    meal.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11, // Scaled down description
                      color: Color(0xFF64748B),
                      height: 1.3, 
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Footer Tag & Calories
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // The pill tag
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0FDF4), 
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: const Color(0xFFBBF7D0)),
                          ),
                          child: Text(
                            meal.primaryTag,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 9, // Scaled down tag text
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF15803D),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // The calories
                      Text(
                        meal.calories,
                        style: const TextStyle(
                          fontSize: 11, // Scaled down calorie text
                          fontWeight: FontWeight.w800,
                          color: Color(0xFFD97706), 
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}