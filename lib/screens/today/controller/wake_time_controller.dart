import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/wake_model.dart';

class WakeTimeController {
  static const String _hourKey = "wake_hour";
  static const String _minuteKey = "wake_minute";

  //----------------------------------------------------------
  // DEFAULT WAKE TIME
  //----------------------------------------------------------

  static const WakeModel defaultWakeTime = WakeModel(
    hour: 6,
    minute: 0,
  );

  //----------------------------------------------------------
  // SAVE
  //----------------------------------------------------------

  Future<void> saveWakeTime(
    TimeOfDay time,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(
      _hourKey,
      time.hour,
    );

    await prefs.setInt(
      _minuteKey,
      time.minute,
    );
  }

  //----------------------------------------------------------
  // LOAD
  //----------------------------------------------------------

  Future<WakeModel> loadWakeTime() async {
    final prefs = await SharedPreferences.getInstance();

    final hour =
        prefs.getInt(_hourKey) ??
        defaultWakeTime.hour;

    final minute =
        prefs.getInt(_minuteKey) ??
        defaultWakeTime.minute;

    return WakeModel(
      hour: hour,
      minute: minute,
    );
  }

  //----------------------------------------------------------
  // HAS USER SET WAKE TIME?
  //----------------------------------------------------------

  Future<bool> hasWakeTime() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.containsKey(_hourKey);
  }

  //----------------------------------------------------------
  // RESET
  //----------------------------------------------------------

  Future<void> resetWakeTime() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_hourKey);
    await prefs.remove(_minuteKey);
  }

  //----------------------------------------------------------
  // TIMEOFDAY
  //----------------------------------------------------------

  Future<TimeOfDay> getTimeOfDay() async {
    final wake = await loadWakeTime();

    return TimeOfDay(
      hour: wake.hour,
      minute: wake.minute,
    );
  }

  //----------------------------------------------------------
  // FORMATTED TIME
  //----------------------------------------------------------

  Future<String> formattedTime() async {
    final wake = await loadWakeTime();

    int hour = wake.hour;

    final minute = wake.minute;

    final period =
        hour >= 12 ? "PM" : "AM";

    hour %= 12;

    if (hour == 0) {
      hour = 12;
    }

    return "$hour:${minute.toString().padLeft(2, '0')} $period";
  }
}