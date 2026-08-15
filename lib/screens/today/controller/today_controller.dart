//----------------------------------------------------------
// IMPORTS
//----------------------------------------------------------

import '../models/activity_model.dart';
import '../models/rhythm_model.dart';
import '../models/timeline_item_model.dart';
import '../models/wake_model.dart';

import 'schedule_engine.dart';
import 'wake_time_controller.dart';

//==========================================================
// TODAY CONTROLLER
//==========================================================

class TodayController {

  //----------------------------------------------------------
  // CONTROLLERS
  //----------------------------------------------------------

  final ScheduleEngine _engine =
      ScheduleEngine();

  final WakeTimeController _wakeController =
      WakeTimeController();

  //----------------------------------------------------------
  // INITIALIZE
  //----------------------------------------------------------

  Future<void> initialize() async {

    final WakeModel wakeTime =
        await _wakeController.loadWakeTime();

    _engine.userWakeTime = wakeTime;
  }

  //----------------------------------------------------------
  // REFRESH WAKE TIME
  //----------------------------------------------------------

  Future<void> refreshWakeTime() async {

    final WakeModel wakeTime =
        await _wakeController.loadWakeTime();

    _engine.userWakeTime = wakeTime;
  }

  //----------------------------------------------------------
  // CURRENT RHYTHM
  //----------------------------------------------------------

  RhythmModel currentRhythm() {
    return _engine.getCurrentRhythm();
  }

  //----------------------------------------------------------
  // CURRENT ACTIVITY
  //----------------------------------------------------------

  ActivityModel currentActivity() {
    return _engine.getCurrentActivity();
  }

  //----------------------------------------------------------
  // TODAY TIMELINE
  //----------------------------------------------------------

  List<TimelineItem> todayTimeline() {
    return _engine.todayTimeline();
  }

  //----------------------------------------------------------
  // REMAINING ACTIVITIES
  //----------------------------------------------------------

  List<ActivityModel>remainingActivities() {
    return _engine.remainingActivities(
      _engine.getCurrentRhythm(),
    );
  }

  //----------------------------------------------------------
  // HERO
  //----------------------------------------------------------

  String heroTitle() =>
      _engine.heroTitle();

  String heroSubtitle() =>
      _engine.heroSubtitle();

  String heroImage() =>
      _engine.heroImage();

  String heroDuration() =>
      _engine.heroDuration();

  //----------------------------------------------------------
  // TIME
  //----------------------------------------------------------

  String activityTime(
    ActivityModel activity,
  ) {
    return _engine.activityTime(
      activity,
    );
  }

  String currentTime() {
    return _engine.currentTime();
  }

  //----------------------------------------------------------
  // RHYTHM
  //----------------------------------------------------------

  String rhythmName() {
    return _engine.rhythmName();
  }

  //----------------------------------------------------------
  // CURRENT INDEX
  //----------------------------------------------------------

  int currentActivityIndex() {

    final timeline =
        todayTimeline();

    final current =
        currentActivity();

    for (int i = 0; i < timeline.length; i++) {

      final item = timeline[i];

      if (!item.isActivity) {
        continue;
      }

      if (item.activity!.id ==
          current.id) {
        return i;
      }
    }

    return -1;
  }
}