import '../../models/activity_model.dart';
import '../../models/rhythm_model.dart';

/// ==========================================================
/// MORNING RHYTHM
/// Time Window : 05:00 AM - 11:00 AM
///
/// Morning activities are generated relative to the user's
/// wake-up time.
///
/// If the user has not set a wake-up time,
/// IRAI uses the default morning schedule.
///
/// Future Additions
/// ----------------------------------------------------------
/// • Wake Up
/// • Hydration
/// • Oil Pulling
/// • Tongue Cleaning
/// • Body Care
/// • Bath
/// • Sunlight Exposure
/// • Prayer
/// • Siddha Herbs
/// • Breathing
/// • Meditation
/// • Yoga
/// • Breakfast
/// • Herbal Tea
/// • Journaling
/// • Reading
/// • Gratitude
/// ==========================================================

const RhythmModel morningRhythm = RhythmModel(
  id: "morning",
  name: "Morning",

  startHour: 5,
  endHour: 11,

  activities: [

    //--------------------------------------------------------
    // HYDRATION
    //--------------------------------------------------------

    ActivityModel(
      id: "hydration",
      title: "Hydration",
      subtitle: "Drink warm water",
      image:
          "https://images.unsplash.com/photo-1548839140-29a749e1cf4d?w=1200",
      offsetMinutes: 0,
      durationMinutes: 5,
      type: ActivityType.hydration,
    ),

    //--------------------------------------------------------
    // BODY CARE
    //--------------------------------------------------------

    ActivityModel(
      id: "bodycare",
      title: "Body Care",
      subtitle: "Freshen and prepare your body",
      image:
          "https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=1200",
      offsetMinutes: 10,
      durationMinutes: 15,
      type: ActivityType.bodyCare,
    ),

    //--------------------------------------------------------
    // MEDITATION
    //--------------------------------------------------------

    ActivityModel(
      id: "meditation",
      title: "Morning Meditation",
      subtitle: "Calm your mind",
      image:
          "https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=1200",
      offsetMinutes: 30,
      durationMinutes: 15,
      type: ActivityType.meditation,
    ),

    //--------------------------------------------------------
    // YOGA
    //--------------------------------------------------------

    ActivityModel(
      id: "yoga",
      title: "Morning Yoga",
      subtitle: "Wake your body gently",
      image:
          "https://images.unsplash.com/photo-1545389336-cf090694435e?w=1200",
      offsetMinutes: 50,
      durationMinutes: 30,
      type: ActivityType.yoga,
    ),

    //--------------------------------------------------------
    // BREAKFAST
    //--------------------------------------------------------

    ActivityModel(
      id: "breakfast",
      title: "Healthy Breakfast",
      subtitle: "Eat nutritious food",
      image:
          "https://images.unsplash.com/photo-1490645935967-10de6ba17061?w=1200",
      offsetMinutes: 90,
      durationMinutes: 30,
      type: ActivityType.breakfast,
    ),

    //--------------------------------------------------------
    // HERBAL TEA
    //--------------------------------------------------------

    ActivityModel(
      id: "tea",
      title: "Herbal Tea",
      subtitle: "Relax and refresh",
      image:
          "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=1200",
      offsetMinutes: 130,
      durationMinutes: 15,
      type: ActivityType.snack,
    ),

    //--------------------------------------------------------
    // BREATHING
    //--------------------------------------------------------

    ActivityModel(
      id: "breathing",
      title: "Breathing",
      subtitle: "Recharge your energy",
      image:
          "https://images.unsplash.com/photo-1518611012118-696072aa579a?w=1200",
      offsetMinutes: 210,
      durationMinutes: 10,
      type: ActivityType.breathing,
    ),
  ],
);