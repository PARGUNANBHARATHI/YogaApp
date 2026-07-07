import '../../models/rhythm_model.dart';

import 'morning_rhythm.dart';
import 'midday_rhythm.dart';
import 'evening_rhythm.dart';
import 'night_rhythm.dart';

/// ===========================================================
/// IRAI DAILY RHYTHM
/// ===========================================================
///
/// The day is divided into four wellness segments.
///
/// 🌅 Morning : 05:00 AM → 11:00 AM
/// ☀ Midday   : 11:00 AM → 03:00 PM
/// 🌇 Evening : 03:00 PM → 07:00 PM
/// 🌙 Night   : 07:00 PM → 05:00 AM
///
/// Future
/// -----------------------------------------------------------
/// • AI Personalized Rhythms
/// • Smart Band Integration
/// • Dynamic Wake Time
/// • Seasonal Recommendations
/// • Siddha Constitution Personalization
///
/// ===========================================================

final List<RhythmModel> dailyRhythms = [

  //------------------------------------------------------------
  // 🌅 MORNING
  //------------------------------------------------------------

  morningRhythm,

  //------------------------------------------------------------
  // ☀ MIDDAY
  //------------------------------------------------------------

  middayRhythm,

  //------------------------------------------------------------
  // 🌇 EVENING
  //------------------------------------------------------------

  eveningRhythm,

  //------------------------------------------------------------
  // 🌙 NIGHT
  //------------------------------------------------------------

  nightRhythm,
];