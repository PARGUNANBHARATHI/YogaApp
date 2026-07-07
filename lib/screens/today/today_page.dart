import 'dart:async';

import 'package:flutter/material.dart';

import 'controller/today_controller.dart';
import 'models/activity_model.dart';

import 'widgets/daily_quote_card.dart';
import 'widgets/flow_item.dart';
import 'widgets/progress_card.dart';
import 'widgets/your_moment_card.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({super.key});

  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  final TodayController controller = TodayController();

  late Timer _timer;

  bool _loading = true;

  @override
  void initState() {
    super.initState();

    _initialize();

    _timer = Timer.periodic(
      const Duration(minutes: 1),
      (_) {
        if (mounted) {
          setState(() {});
        }
      },
    );
  }

  Future<void> _initialize() async {
    await controller.initialize();

    if (!mounted) return;

    setState(() {
      _loading = false;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  IconData _getIcon(ActivityType type) {
    switch (type) {
      case ActivityType.hydration:
        return Icons.water_drop_rounded;

      case ActivityType.bodyCare:
        return Icons.spa_rounded;

      case ActivityType.meditation:
        return Icons.self_improvement_rounded;

      case ActivityType.yoga:
        return Icons.accessibility_new_rounded;

      case ActivityType.breakfast:
        return Icons.breakfast_dining_rounded;

      case ActivityType.lunch:
        return Icons.lunch_dining_rounded;

      case ActivityType.dinner:
        return Icons.dinner_dining_rounded;

      case ActivityType.snack:
        return Icons.local_cafe_rounded;

      case ActivityType.walking:
        return Icons.directions_walk_rounded;

      case ActivityType.breathing:
        return Icons.air_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: Color(0xFFF6F7F3),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final hero = controller.currentActivity();
    final activities = controller.activities();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F3),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverToBoxAdapter(
                child: YourMomentCard(
                  title: hero.title,
                  focus: hero.subtitle,
                  duration: "${hero.durationMinutes} min",
                  image: hero.image,
                  onTap: () {},
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 30),
            ),

            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "Today's Flow",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 15),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = activities[index];

                    return FlowItem(
                      time: controller.activityTime(item),
                      title: item.title,
                      subtitle: item.subtitle,
                      status: "Recommended",
                      icon: _getIcon(item.type),
                      onTap: () {},
                    );
                  },
                  childCount: activities.length,
                ),
              ),
            ),

            const SliverPadding(
              padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
              sliver: SliverToBoxAdapter(
                child: ProgressCard(
                  completed: 0,
                  total: 7,
                ),
              ),
            ),

            const SliverPadding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
              sliver: SliverToBoxAdapter(
                child: DailyQuoteCard(
                  quote:
                      "Every healthy day begins with one mindful step.",
                  author: "IRAI",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}