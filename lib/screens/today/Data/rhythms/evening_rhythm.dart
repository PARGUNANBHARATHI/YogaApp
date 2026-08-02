import '../../models/activity_model.dart';
import '../../models/rhythm_model.dart';

/// ==========================================================
/// EVENING RHYTHM
/// Time Window : 03:00 PM - 07:00 PM
///
/// Evening follows REAL CLOCK time.
///
/// It does NOT depend on wake-up time.
///
/// Future Additions
/// ----------------------------------------------------------
/// • Healthy Snack
/// • Water Reminder
/// • Evening Walk
/// • Workout
/// • Yoga
/// • Stretching
/// • Recovery
/// • Siddha Herbs
/// • Family Time
/// • Sunset Meditation
/// • Fresh Juice
/// • Cycling
/// • Outdoor Activity
/// ==========================================================

const RhythmModel eveningRhythm = RhythmModel(
  id: "evening",

  name: "Evening",

  startHour: 15,

  endHour: 19,

  activities: [

    //--------------------------------------------------------
    // HEALTHY SNACK
    //--------------------------------------------------------

    ActivityModel(
      id: "snack",
      title: "Healthy Snack",
      subtitle: "Light and nutritious snack",
      image:
          "https://images.unsplash.com/photo-1482049016688-2d3e1b311543?w=1200",

      hour: 15,
      minute: 30,

      durationMinutes: 15,

      type: ActivityType.snack,
    ),

    //--------------------------------------------------------
    // HYDRATION
    //--------------------------------------------------------

    ActivityModel(
      id: "hydration",
      title: "Surya Namaskaram",
      subtitle: " Do Surra namaskaram 5 min",
      image:
          "https://images.unsplash.com/photo-1548839140-29a749e1cf4d?w=1200",

      hour: 16,
      minute: 0,

      durationMinutes: 15,

      type: ActivityType.hydration,
    ),

    //--------------------------------------------------------
    // EVENING WALK
    //--------------------------------------------------------

    ActivityModel(
      id: "walk",
      title: "Evening Walk",
      subtitle: "Walk for 20–30 minutes",
      image:
          "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=1200",

      hour: 17,
      minute: 30,

      durationMinutes: 30,

      type: ActivityType.walking,
    ),

    //--------------------------------------------------------
    // LIGHT WORKOUT
    //--------------------------------------------------------

    ActivityModel(
      id: "workout",
      title: "Light Workout",
      subtitle: "Strength & mobility exercises",
      image:
          "https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=1200",

      hour: 18,
      minute: 0,

      durationMinutes: 30,

      type: ActivityType.yoga,
    ),

    //--------------------------------------------------------
    // STRETCHING
    //--------------------------------------------------------

    ActivityModel(
      id: "stretching",
      title: "Stretching",
      subtitle: "Relax your muscles",
      image:
          "https://images.unsplash.com/photo-1545389336-cf090694435e?w=1200",

      hour: 18,
      minute: 30,

      durationMinutes: 15,

      type: ActivityType.yoga,
    ),

    //--------------------------------------------------------
    // RECOVERY
    //--------------------------------------------------------

    ActivityModel(
      id: "recovery",
      title: "Recovery",
      subtitle: "Cool down and relax",
      image:
          "https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=1200",

      hour: 18,
      minute: 50,

      durationMinutes: 10,

      type: ActivityType.meditation,
    ),
  ],
);