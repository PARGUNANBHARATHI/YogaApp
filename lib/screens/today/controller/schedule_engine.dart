import '../data/rhythms/daily_rhythm.dart';
import '../models/activity_model.dart';
import '../models/rhythm_model.dart';
import '../models/wake_model.dart';

class ScheduleEngine {
  //----------------------------------------------------------
  // DEFAULT WAKE TIME
  //----------------------------------------------------------
  // Used when user has not configured wake-up time.
  // Later this will come from SharedPreferences.
  //----------------------------------------------------------

  static const WakeModel defaultWakeTime = WakeModel(
    hour: 6,
    minute: 0,
  );

  //----------------------------------------------------------
  // USER WAKE TIME
  //----------------------------------------------------------
  // Future:
  // Read from Settings / Firebase / Smart Band
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
      if (rhythm.startHour < rhythm.endHour) {
        if (now.hour >= rhythm.startHour &&
            now.hour < rhythm.endHour) {
          return rhythm;
        }
      } else {
        // Night (19 → 05)

        if (now.hour >= rhythm.startHour ||
            now.hour < rhythm.endHour) {
          return rhythm;
        }
      }
    }

   return dailyRhythms.first;
  }

  //----------------------------------------------------------
  // CURRENT ACTIVITY
  //----------------------------------------------------------

  ActivityModel getCurrentActivity() {
    final rhythm = getCurrentRhythm();

    final now = DateTime.now();

    ActivityModel current =
        rhythm.activities.first;

    for (final activity in rhythm.activities) {
      final activityDateTime =
          activityDate(activity);

      if (now.isAfter(activityDateTime) ||
          now.isAtSameMomentAs(activityDateTime)) {
        current = activity;
      } else {
        break;
      }
    }

    return current;
  }

  //----------------------------------------------------------
  // CURRENT FLOW
  //----------------------------------------------------------

  List<ActivityModel> activities() {
    return getCurrentRhythm().activities;
  }

  //----------------------------------------------------------
  // RHYTHM NAME
  //----------------------------------------------------------

  String rhythmName() {
    return getCurrentRhythm().name;
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
  // ACTIVITY DATE
  //----------------------------------------------------------

  DateTime activityDate(
      ActivityModel activity) {
    final now = DateTime.now();

    //------------------------------------------------------
    // MORNING
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
  // FORMAT TIME
  //----------------------------------------------------------

  String activityTime(
      ActivityModel activity) {
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
  // FORMATTER
  //----------------------------------------------------------

  String formatTime(
      DateTime dateTime) {
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
  // FUTURE
  //----------------------------------------------------------
  //
  // V2
  // • Wake Time Settings
  // • Shared Preferences
  //
  // V3
  // • AI Recommendation
  // • Smart Band
  // • Weather
  // • Siddha Personalization
  //
  //----------------------------------------------------------
}