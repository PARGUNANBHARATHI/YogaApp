import 'dart:ui';
import 'package:flutter/material.dart';

// ============================================================================
// 1. PRO FEED SCREEN (AMBIENT BACKGROUND & PERFECT ALIGNMENT)
// ============================================================================
class ProYogaFeedScreen extends StatefulWidget {
  const ProYogaFeedScreen({super.key});

  @override
  State<ProYogaFeedScreen> createState() => _ProYogaFeedScreenState();
}

class _ProYogaFeedScreenState extends State<ProYogaFeedScreen> {
  String _activeFilter = 'All';
  
  final List<String> _filters = [
    
   
    'Asanas',
    'Mundra',
    'Meditation',
    'Recovery',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09090B), // Deepest obsidian black
      body: Stack(
        children: [
          // ================= AMBIENT MESH BACKGROUND =================
          Positioned(
            top: -100,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF2FA7B2).withValues(alpha: 0.15), // Teal Glow
              ),
            ),
          ),
          Positioned(
            top: 250,
            right: -100,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFEAB308).withValues(alpha: 0.10), // Gold Glow
              ),
            ),
          ),
          // Massive blur to create ambient light
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
            child: Container(color: Colors.transparent),
          ),

          // ================= MAIN CONTENT =================
          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- PREMIUM HEADER ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Personalize',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Elevate YOGA Practice',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                      // PRO Badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFF59E0B), Color(0xFFF97316)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFF59E0B).withValues(alpha: 0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Text(
                          'PRO',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 12),

                // --- HORIZONTAL FILTERS (PERFECTLY ALIGNED) ---
                SizedBox(
                  height: 38,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24), // Aligned with header
                    itemCount: _filters.length,
                    itemBuilder: (context, index) {
                      final filter = _filters[index];
                      final isSelected = filter == _activeFilter;
                      
                      return GestureDetector(
                        onTap: () => setState(() => _activeFilter = filter),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOutCubic,
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? Colors.white 
                                : Colors.white.withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected 
                                  ? Colors.white 
                                  : Colors.white.withValues(alpha: 0.1),
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              filter,
                              style: TextStyle(
                                color: isSelected ? const Color(0xFF09090B) : Colors.white70,
                                fontSize: 14,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // --- ORGANIZED VERTICAL LIST ---
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    children: const [
                      ProCinematicCard(
                        title: 'Mastering the Mind',
                        category: 'MEDITATION',
                        time: '20 Min',
                        intensity: 'Pro Level',
                        image: 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?q=80&w=800&auto=format&fit=crop',
                        isPremium: true,
                      ),
                      SizedBox(height: 24),
                      ProCinematicCard(
                        title: 'Dynamic Surya Flow',
                        category: 'MORNING FLOW',
                        time: '15 Min',
                        intensity: 'Moderate',
                        image: 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?q=80&w=800&auto=format&fit=crop',
                        isPremium: false,
                      ),
                      SizedBox(height: 24),
                      ProCinematicCard(
                        title: 'Deep Tissue Release',
                        category: 'RECOVERY',
                        time: '45 Min',
                        intensity: 'Gentle',
                        image: 'https://images.unsplash.com/photo-1599901860904-17e6ed7083a0?q=80&w=800&auto=format&fit=crop',
                        isPremium: true,
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 2. THE PRO CINEMATIC CARD (GLASS BORDERS & REFINED GRADIENTS)
// ============================================================================
class ProCinematicCard extends StatefulWidget {
  final String title;
  final String category;
  final String time;
  final String intensity;
  final String image;
  final bool isPremium;

  const ProCinematicCard({
    super.key,
    required this.title,
    required this.category,
    required this.time,
    required this.intensity,
    required this.image,
    this.isPremium = false,
  });

  @override
  State<ProCinematicCard> createState() => _ProCinematicCardState();
}

class _ProCinematicCardState extends State<ProCinematicCard> {
  bool _isPressed = false;
  bool _isSaved = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutQuart,
        child: Container(
          height: 260, // Slightly taller for ultra-premium feel
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32), // Softer, rounder corners
            // Glassmorphic border
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.15),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Stack(
              children: [
                // 1. BACKGROUND IMAGE
                Image.network(
                  widget.image,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                // 2. ULTRA-SMOOTH CINEMATIC GRADIENT
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.2),
                        Colors.transparent,
                        const Color(0xFF09090B).withValues(alpha: 0.6),
                        const Color(0xFF09090B).withValues(alpha: 0.95),
                      ],
                      stops: const [0.0, 0.4, 0.7, 1.0],
                    ),
                  ),
                ),

                // 3. TOP BADGES (Aligned to 20px padding inside card)
                Positioned(
                  top: 20,
                  left: 20,
                  right: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Category Badge
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            color: Colors.black.withValues(alpha: 0.3),
                            child: Row(
                              children: [
                                if (widget.isPremium) ...[
                                  const Icon(Icons.workspace_premium_rounded, color: Color(0xFFF59E0B), size: 14),
                                  const SizedBox(width: 4),
                                ],
                                Text(
                                  widget.category,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      
                      // Bookmark Action
                      GestureDetector(
                        onTap: () => setState(() => _isSaved = !_isSaved),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                            child: Container(
                              height: 40,
                              width: 40,
                              color: Colors.black.withValues(alpha: 0.3),
                              child: Icon(
                                _isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                                color: _isSaved ? const Color(0xFF2FA7B2) : Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // 4. BOTTOM CONTENT (Perfectly aligned)
                Positioned(
                  bottom: 24,
                  left: 20,
                  right: 20,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                height: 1.1,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                _buildIconText(Icons.schedule_rounded, widget.time),
                                const SizedBox(width: 16),
                                _buildIconText(Icons.bar_chart_rounded, widget.intensity),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      // Frosted Play Button
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 1.5),
                            ),
                            child: const Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ),
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

  Widget _buildIconText(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white.withValues(alpha: 0.7), size: 16),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.9),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}