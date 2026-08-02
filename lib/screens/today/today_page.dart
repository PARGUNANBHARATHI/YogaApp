//----------------------------------------------------------
// IMPORTS
//----------------------------------------------------------

import 'dart:async';

import 'package:flutter/material.dart';

import 'controller/today_controller.dart';
import 'controller/wake_time_controller.dart';

import 'models/activity_model.dart';
import 'models/timeline_item_model.dart';

import 'settings/wake_time_page.dart';

import 'widgets/daily_quote_card.dart';
import 'widgets/flow_item.dart';
import 'widgets/progress_card.dart';
import 'widgets/timeline_header.dart';
import 'widgets/your_moment_card.dart';

//==========================================================
// TODAY PAGE
//==========================================================

class TodayPage extends StatefulWidget {
  const TodayPage({super.key});

  @override
  State<TodayPage> createState() =>
      _TodayPageState();
}

class _TodayPageState
    extends State<TodayPage> {

  //----------------------------------------------------------
  // CONTROLLERS
  //----------------------------------------------------------

  final TodayController controller =
      TodayController();

  final WakeTimeController wakeController =
      WakeTimeController();

  //----------------------------------------------------------
  // VARIABLES
  //----------------------------------------------------------

  late Timer _timer;

  bool _loading = true;

  //----------------------------------------------------------
  // INIT
  //----------------------------------------------------------

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

  //----------------------------------------------------------
  // INITIALIZE
  //----------------------------------------------------------

  Future<void> _initialize() async {
    await controller.initialize();

    if (!mounted) return;

    setState(() {
      _loading = false;
    });
  }

  //----------------------------------------------------------
  // DISPOSE
  //----------------------------------------------------------

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  //----------------------------------------------------------
  // WAKE TIME PAGE
  //----------------------------------------------------------

  Future<void> _openWakeTime() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const WakeTimePage(),
      ),
    );

    if (result != null) {
      await controller.refreshWakeTime();

      if (!mounted) return;

      setState(() {});
    }
  }

  //----------------------------------------------------------
  // ICONS
  //----------------------------------------------------------

  IconData _getIcon(
    ActivityType type,
  ) {
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

  //----------------------------------------------------------
  // BUILD
  //----------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    //--------------------------------------------------------
    // LOADING
    //--------------------------------------------------------

    if (_loading) {
      return const Scaffold(
        backgroundColor: Color(0xFFF6F7F3),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    //--------------------------------------------------------
    // DATA
    //--------------------------------------------------------

    final hero =
        controller.currentActivity();

    final timeline =
        controller.todayTimeline();

    //--------------------------------------------------------
    // PAGE
    //--------------------------------------------------------

    return Scaffold(
      backgroundColor:
          const Color(0xFFF6F7F3),

      body: SafeArea(
        child: CustomScrollView(
          physics:
              const BouncingScrollPhysics(),

          slivers: [

            //------------------------------------------------
            // TOP SPACE
            //------------------------------------------------

            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
//----------------------------------------------------------
// PREMIUM HEADER
//----------------------------------------------------------

SliverPadding(
  padding: const EdgeInsets.fromLTRB(
    20,
    0,
    20,
    18,
  ),
  sliver: SliverToBoxAdapter(
    child: FutureBuilder<String>(
      future: wakeController.formattedTime(),
      builder: (context, snapshot) {
        return InkWell(
          onTap: _openWakeTime,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            height: 140,
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 20,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF1B2236),
                  Color(0xFF111827),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius:
                  BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: .15,
                  ),
                  blurRadius: 25,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Row(
              children: [

                //------------------------------------------------
                // LEFT
                //------------------------------------------------

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      Text(
                        controller.rhythmName(),
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 7),

                      const Text(
                        "IRAI",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Spacer(),

                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius:
                              BorderRadius.circular(
                                  40),
                        ),
                        child: Row(
                          mainAxisSize:
                              MainAxisSize.min,
                          children: [

                            Container(
                              width: 10,
                              height: 10,
                              decoration:
                                  const BoxDecoration(
                                color: Color(
                                    0xFF39D98A),
                                shape:
                                    BoxShape.circle,
                              ),
                            ),

                            const SizedBox(width: 10),

                            Text(
                              "Wake • ${snapshot.data ?? "--"}",
                              style:
                                  const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight:
                                    FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //------------------------------------------------
                // RIGHT
                //------------------------------------------------

                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(
                      alpha: .06,
                    ),
                    borderRadius:
                        BorderRadius.circular(18),
                    border: Border.all(
                      color: Colors.white12,
                    ),
                  ),
                  child: const Icon(
                    Icons.alarm_rounded,
                    color: Color(0xFF49D6E5),
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  ),
),
            //------------------------------------------------
            // HERO
            //------------------------------------------------

            SliverPadding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              sliver: SliverToBoxAdapter(
                child: YourMomentCard(
                  title: hero.title,
                  focus: hero.subtitle,
                  duration:
                      "${hero.durationMinutes} min",
                  image: hero.image,
                  onTap: () {},
                ),
              ),
            ),

            //------------------------------------------------
            // SPACE
            //------------------------------------------------

            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),

            //------------------------------------------------
            // TODAY FLOW TITLE
            //------------------------------------------------

            const SliverPadding(
              padding:
                  EdgeInsets.symmetric(
                horizontal: 25,
              ),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "Today's Flow",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(
                height: 0,
              ),
            ),
                        //------------------------------------------------
            // TODAY TIMELINE
            //------------------------------------------------

            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(

                  (context, index) {

                    final item =
                        timeline[index];

                    //----------------------------------------
                    // RHYTHM HEADER
                    //----------------------------------------

                    if (item.isHeader) {

                      return TimelineHeader(
                        title: item.title,
                      );

                    }

                    //----------------------------------------
                    // ACTIVITY
                    //----------------------------------------

                    final activity =
                        item.activity!;

                    final isCurrent =
                        activity.id ==
                        hero.id;

                    return FlowItem(

                      //--------------------------------------
                      // TIME
                      //--------------------------------------

                      time: controller.activityTime(
                        activity,
                      ),

                      //--------------------------------------
                      // TITLE
                      //--------------------------------------

                      title: activity.title,

                      //--------------------------------------
                      // SUBTITLE
                      //--------------------------------------

                      subtitle:
                          activity.subtitle,

                      //--------------------------------------
                      // STATUS
                      //--------------------------------------

                      status: isCurrent
                          ? "Now"
                          : "",

                      //--------------------------------------
                      // ICON
                      //--------------------------------------

                      icon: _getIcon(
                        activity.type,
                      ),

                      //--------------------------------------
                      // TAP
                      //--------------------------------------

                      onTap: () {

                        // TODO
                        // Open activity page

                      },

                    );

                  },

                  childCount:
                      timeline.length,

                ),
              ),
            ),

            //------------------------------------------------
            // SPACE
            //------------------------------------------------

            const SliverToBoxAdapter(
              child: SizedBox(
                height: 18,
              ),
            ),

            //------------------------------------------------
            // TODAY SUMMARY
            //------------------------------------------------

            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              sliver: SliverToBoxAdapter(

                child: ProgressCard(

                  total: timeline
                      .where(
                        (item) =>
                            item.isActivity,
                      )
                      .length,

                ),

              ),
            ),

            //------------------------------------------------
            // SPACE
            //------------------------------------------------

            const SliverToBoxAdapter(
              child: SizedBox(
                height: 24,
              ),
            ),
                        //------------------------------------------------
            // DAILY QUOTE
            //------------------------------------------------

            const SliverPadding(
              padding: EdgeInsets.fromLTRB(
                20,
                0,
                20,
                24,
              ),
              sliver: SliverToBoxAdapter(
                child: DailyQuoteCard(
                  quote:
                      "Small healthy choices repeated every day create an extraordinary life.",
                  author: "IRAI",
                ),
              ),
            ),

            //------------------------------------------------
            // BOTTOM SAFE SPACE
            //------------------------------------------------

            const SliverToBoxAdapter(
              child: SizedBox(
                height: 40,
              ),
            ),

          ],
        ),
      ),
    );
  }
}