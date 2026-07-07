import '../../models/activity_model.dart';
import '../../models/rhythm_model.dart';

/// ==========================================================
/// NIGHT RHYTHM
/// Time Window : 07:00 PM - 05:00 AM
///
/// Night follows REAL CLOCK time.
///
/// It does NOT depend on wake-up time.
///
/// Future Additions
/// ----------------------------------------------------------
/// • Dinner
/// • Herbal Drink
/// • Family Time
/// • Screen-Free Time
/// • Reading
/// • Meditation
/// • Gratitude Journal
/// • Sleep Preparation
/// • Sleep
/// • Siddha Herbs
/// • Digital Detox
/// • Relaxing Music
/// ==========================================================

const RhythmModel nightRhythm = RhythmModel(
  id: "night",

  name: "Night",

  startHour: 19,

  endHour: 5,

  activities: [

    //--------------------------------------------------------
    // DINNER
    //--------------------------------------------------------

    ActivityModel(
      id: "dinner",
      title: "Healthy Dinner",
      subtitle: "Eat a light and balanced dinner",
      image:
          "https://images.unsplash.com/photo-1544025162-d76694265947?w=1200",

      hour: 19,
      minute: 30,

      durationMinutes: 30,

      type: ActivityType.dinner,
    ),

    //--------------------------------------------------------
    // HERBAL DRINK
    //--------------------------------------------------------

    ActivityModel(
      id: "herbal_drink",
      title: "Herbal Drink",
      subtitle: "Relax with a warm herbal drink",
      image:
          "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=1200",

      hour: 20,
      minute: 15,

      durationMinutes: 10,

      type: ActivityType.snack,
    ),

    //--------------------------------------------------------
    // FAMILY TIME
    //--------------------------------------------------------

    ActivityModel(
      id: "family",
      title: "Family Time",
      subtitle: "Spend quality time with loved ones",
      image:
          "https://images.unsplash.com/photo-1511895426328-dc8714191300?w=1200",

      hour: 20,
      minute: 45,

      durationMinutes: 45,

      type: ActivityType.meditation,
    ),

    //--------------------------------------------------------
    // SCREEN FREE
    //--------------------------------------------------------

    ActivityModel(
      id: "screen_free",
      title: "Screen-Free Time",
      subtitle: "Reduce screen usage before sleep",
      image:
          "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=1200",

      hour: 21,
      minute: 30,

      durationMinutes: 30,

      type: ActivityType.meditation,
    ),

    //--------------------------------------------------------
    // NIGHT MEDITATION
    //--------------------------------------------------------

    ActivityModel(
      id: "night_meditation",
      title: "Night Meditation",
      subtitle: "Relax your mind before sleep",
      image:
          "https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=1200",

      hour: 22,
      minute: 0,

      durationMinutes: 20,

      type: ActivityType.meditation,
    ),

    //--------------------------------------------------------
    // SLEEP
    //--------------------------------------------------------

    ActivityModel(
      id: "sleep",
      title: "Sleep",
      subtitle: "Have a peaceful night's sleep",
      image:
          "https://images.unsplash.com/photo-1455642305367-68834a7cb1fa?w=1200",

      hour: 22,
      minute: 30,

      durationMinutes: 480,

      type: ActivityType.meditation,
    ),
  ],
);