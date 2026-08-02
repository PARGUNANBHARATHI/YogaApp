//----------------------------------------------------------
// IMPORTS
//----------------------------------------------------------

import '../data/rhythms/daily_rhythm.dart';
import '../data/rhythms/morning_rhythm.dart';
import '../data/rhythms/midday_rhythm.dart';
import '../data/rhythms/evening_rhythm.dart';
import '../data/rhythms/night_rhythm.dart';

import '../models/activity_model.dart';
import '../models/rhythm_model.dart';
import '../models/timeline_item_model.dart';
import '../models/wake_model.dart';

//==========================================================
// SCHEDULE ENGINE
//==========================================================

class ScheduleEngine {

  //----------------------------------------------------------
  // DEFAULT WAKE TIME
  //----------------------------------------------------------

  static const WakeModel defaultWakeTime =
      WakeModel(
    hour: 6,
    minute: 0,
  );

  //----------------------------------------------------------
  // USER WAKE TIME
  //----------------------------------------------------------

  WakeModel? userWakeTime;

  //----------------------------------------------------------
  // ACTIVE WAKE TIME
  //----------------------------------------------------------

  WakeModel get wakeTime =>
      userWakeTime ?? defaultWakeTime;

  //----------------------------------------------------------
  // CURRENT RHYTHM
  //----------------------------------------------------------

  RhythmModel getCurrentRhythm() {
    final now = DateTime.now();

    for (final rhythm in dailyRhythms) {

      //------------------------------------------------------
      // NORMAL RHYTHM
      //------------------------------------------------------

      if (rhythm.startHour < rhythm.endHour) {

        if (now.hour >= rhythm.startHour &&
            now.hour < rhythm.endHour) {
          return rhythm;
        }

      }

      //------------------------------------------------------
      // NIGHT RHYTHM
      //------------------------------------------------------

      else {

        if (now.hour >= rhythm.startHour ||
            now.hour < rhythm.endHour) {
          return rhythm;
        }

      }

    }

    return morningRhythm;
  }

  //----------------------------------------------------------
  // ALL ACTIVITIES OF CURRENT RHYTHM
  //----------------------------------------------------------

  List<ActivityModel> activities() {
    return getCurrentRhythm().activities;
  }

  //----------------------------------------------------------
  // ACTIVITY START TIME
  //----------------------------------------------------------

  DateTime activityDate(
      ActivityModel activity,
  ) {

    final now = DateTime.now();

    //------------------------------------------------------
    // WAKE BASED
    //------------------------------------------------------

    if (activity.usesWakeTime) {

      return wakeTime.wakeTime.add(

        Duration(
          minutes:
              activity.offsetMinutes!,
        ),

      );

    }

    //------------------------------------------------------
    // REAL CLOCK
    //------------------------------------------------------

    return DateTime(

      now.year,
      now.month,
      now.day,

      activity.hour!,
      activity.minute!,

    );

  }

  //----------------------------------------------------------
  // ACTIVITY END TIME
  //----------------------------------------------------------

  DateTime activityEnd(
      ActivityModel activity,
  ) {

    return activityDate(activity).add(

      Duration(

        minutes:
            activity.durationMinutes,

      ),

    );

  }

  //----------------------------------------------------------
  // IS CURRENT ACTIVITY
  //----------------------------------------------------------

  bool isCurrentActivity(
      ActivityModel activity,
  ) {

    final now = DateTime.now();

    return (now.isAfter(
                activityDate(activity),
            ) ||
            now.isAtSameMomentAs(
                activityDate(activity),
            )) &&
        now.isBefore(
          activityEnd(activity),
        );

  }
    //----------------------------------------------------------
  // CURRENT ACTIVITY
  //----------------------------------------------------------

  ActivityModel getCurrentActivity() {
    final rhythm = getCurrentRhythm();

    for (final activity in rhythm.activities) {
      if (isCurrentActivity(activity)) {
        return activity;
      }
    }

    //------------------------------------------------------
    // FALLBACK
    //------------------------------------------------------

    ActivityModel current =
        rhythm.activities.first;

    final now = DateTime.now();

    for (final activity in rhythm.activities) {
      if (activityDate(activity).isBefore(now) ||
          activityDate(activity)
              .isAtSameMomentAs(now)) {
        current = activity;
      }
    }

    return current;
  }

  //----------------------------------------------------------
  // HERO
  //----------------------------------------------------------

  String heroTitle() =>
      getCurrentActivity().title;

  String heroSubtitle() =>
      getCurrentActivity().subtitle;

  String heroImage() =>
      getCurrentActivity().image;

  String heroDuration() =>
      "${getCurrentActivity().durationMinutes} min";
  //----------------------------------------------------------
  // REMAINING ACTIVITIES
  //----------------------------------------------------------

  List<ActivityModel> remainingActivities(
    RhythmModel rhythm,
  ) {
    final now = DateTime.now();

    final List<ActivityModel> remaining = [];

    for (final activity in rhythm.activities) {
      final end = activityEnd(activity);

      //------------------------------------------------------
      // HIDE COMPLETED ACTIVITIES
      //------------------------------------------------------

      if (end.isBefore(now)) {
        continue;
      }

      remaining.add(activity);
    }

    return remaining;
  }

  //----------------------------------------------------------
  // TODAY TIMELINE
  //----------------------------------------------------------

  List<TimelineItem> todayTimeline() {
    final List<TimelineItem> timeline = [];

    final rhythms = <RhythmModel>[
      morningRhythm,
      middayRhythm,
      eveningRhythm,
      nightRhythm,
    ];

    for (final rhythm in rhythms) {
      final remaining = remainingActivities(rhythm);

      //------------------------------------------------------
      // SKIP EMPTY RHYTHM
      //------------------------------------------------------

      if (remaining.isEmpty) {
        continue;
      }

      //------------------------------------------------------
      // RHYTHM HEADER
      //------------------------------------------------------

      timeline.add(
        TimelineItem.header(
          title: rhythm.name,
        ),
      );

      //------------------------------------------------------
      // ACTIVITIES
      //------------------------------------------------------

      for (final activity in remaining) {
        timeline.add(
          TimelineItem.activity(
            activity: activity,
          ),
        );
      }
    }

    return timeline;
  }

  //----------------------------------------------------------
  // APPEND RHYTHM
  //----------------------------------------------------------

  void _appendRhythm(
    List<TimelineItem> timeline,
    RhythmModel rhythm,
  ) {
    final activities =
        remainingActivities(rhythm);

    if (activities.isEmpty) {
      return;
    }

    //------------------------------------------------------
    // HEADER
    //------------------------------------------------------

    timeline.add(
      TimelineItem.header(
        title: rhythm.name,
      ),
    );

    //------------------------------------------------------
    // ACTIVITIES
    //------------------------------------------------------

    for (final activity in activities) {
      timeline.add(
        TimelineItem.activity(
          activity: activity,
        ),
      );
    }
  }
    //----------------------------------------------------------
  // CURRENT RHYTHM NAME
  //----------------------------------------------------------

  String rhythmName() {
    return getCurrentRhythm().name;
  }

  //----------------------------------------------------------
  // ACTIVITY TIME
  //----------------------------------------------------------

  String activityTime(
    ActivityModel activity,
  ) {
    return formatTime(
      activityDate(activity),
    );
  }

  //----------------------------------------------------------
  // CURRENT TIME
  //----------------------------------------------------------

  String currentTime() {
    return formatTime(
      DateTime.now(),
    );
  }

  //----------------------------------------------------------
  // FORMAT TIME
  //----------------------------------------------------------

  String formatTime(
    DateTime dateTime,
  ) {
    int hour = dateTime.hour;

    final minute = dateTime.minute;

    final period =
        hour >= 12 ? "PM" : "AM";

    hour %= 12;

    if (hour == 0) {
      hour = 12;
    }

    return "$hour:${minute.toString().padLeft(2, '0')} $period";
  }

  //----------------------------------------------------------
  // CURRENT ACTIVITY INDEX
  //----------------------------------------------------------

  int currentActivityIndex() {
    final timeline = todayTimeline();

    for (int i = 0; i < timeline.length; i++) {
      final item = timeline[i];

      if (!item.isActivity) {
        continue;
      }

      if (item.activity!.id ==
          getCurrentActivity().id) {
        return i;
      }
    }

    return -1;
  }
}