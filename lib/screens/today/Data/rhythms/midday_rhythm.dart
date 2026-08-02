import '../../models/activity_model.dart';
import '../../models/rhythm_model.dart';

/// ==========================================================
/// MIDDAY RHYTHM
/// Time Window : 11:00 AM - 03:00 PM
///
/// Midday follows REAL CLOCK time.
///
/// It does NOT depend on wake-up time.
///
/// Future Additions
/// ----------------------------------------------------------
/// • Water Reminder
/// • Lunch
/// • Fruit
/// • Siddha Herbs
/// • Walking
/// • Eye Relaxation
/// • Stretch Break
/// • Breathing
/// • Mindfulness
/// • Power Nap
/// • Digestive Care
/// ==========================================================

const RhythmModel middayRhythm = RhythmModel(
  id: "midday",

  name: "Midday",

  startHour: 11,

  endHour: 15,

  activities: [

    //--------------------------------------------------------
    // WATER
    //--------------------------------------------------------

    ActivityModel(
      id: "water",
      title: "Hydration",
      subtitle: "Drink a glass of water",
      image:
          "https://images.unsplash.com/photo-1548839140-29a749e1cf4d?w=1200",

      hour: 11,
      minute: 30,

      durationMinutes: 5,

      type: ActivityType.hydration,
    ),

    //--------------------------------------------------------
    // LUNCH
    //--------------------------------------------------------

    ActivityModel(
      id: "lunch",
      title: "Healthy Lunch",
      subtitle: "Balanced nutritious meal",
      image:
          "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=1200",

      hour: 12,
      minute: 30,

      durationMinutes: 30,

      type: ActivityType.lunch,
    ),

    //--------------------------------------------------------
    // WALK
    //--------------------------------------------------------

    ActivityModel(
      id: "Surya Namashakaram",
      title: "Short Walk",
      subtitle: "DO for 15 minutes",
      image:
          "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=1200",

      hour: 13,
      minute: 30,

      durationMinutes: 20,

      type: ActivityType.walking,
    ),

    //--------------------------------------------------------
    // BREATHING
    //--------------------------------------------------------

    ActivityModel(
      id: "breathing",
      title: "Breathing Break",
      subtitle: "Refresh your body and mind",
      image:
          "https://images.unsplash.com/photo-1518611012118-696072aa579a?w=1200",

      hour: 14,
      minute: 30,

      durationMinutes: 10,

      type: ActivityType.breathing,
    ),
  ],
);