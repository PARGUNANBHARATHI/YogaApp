import '../models/activity_model.dart';
import '../models/rhythm_model.dart';
import '../models/wake_model.dart';

import 'schedule_engine.dart';
import 'wake_time_controller.dart';

class TodayController {
  final ScheduleEngine _engine = ScheduleEngine();

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
  // CHANGE WAKE TIME
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
  // TODAY FLOW
  //----------------------------------------------------------

  List<ActivityModel> activities() {
    return _engine.activities();
  }

  //----------------------------------------------------------
  // RHYTHM NAME
  //----------------------------------------------------------

  String rhythmName() {
    return _engine.rhythmName();
  }

  //----------------------------------------------------------
  // HERO
  //----------------------------------------------------------

  String heroTitle() {
    return _engine.heroTitle();
  }

  String heroSubtitle() {
    return _engine.heroSubtitle();
  }

  String heroImage() {
    return _engine.heroImage();
  }

  String heroDuration() {
    return _engine.heroDuration();
  }

  //----------------------------------------------------------
  // TIME
  //----------------------------------------------------------

  String activityTime(ActivityModel activity) {
    return _engine.activityTime(activity);
  }

  String currentTime() {
    return _engine.currentTime();
  }

  //----------------------------------------------------------
  // FUTURE
  //----------------------------------------------------------
  //
  // V2
  // • Wake Time Settings
  // • Notifications
  //
  // V3
  // • AI Recommendation
  // • Smart Band
  //
  //----------------------------------------------------------
}