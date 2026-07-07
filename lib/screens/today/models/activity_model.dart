enum ActivityType {
  hydration,
  bodyCare,
  meditation,
  yoga,
  breakfast,

  lunch,
  dinner,

  snack,
  breathing,
  walking,
}

class ActivityModel {
  final String id;

  final String title;

  final String subtitle;

  final String image;

  //----------------------------------------------------------
  // MORNING
  // Relative to wake-up time
  //----------------------------------------------------------

  final int? offsetMinutes;

  //----------------------------------------------------------
  // MIDDAY / EVENING / NIGHT
  // Fixed clock time
  //----------------------------------------------------------

  final int? hour;

  final int? minute;

  //----------------------------------------------------------

  final int durationMinutes;

  final ActivityType type;

  const ActivityModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,

    this.offsetMinutes,

    this.hour,
    this.minute,

    required this.durationMinutes,
    required this.type,
  });

  //----------------------------------------------------------
  // HELPERS
  //----------------------------------------------------------

  bool get usesWakeTime => offsetMinutes != null;

  bool get usesClockTime =>
      hour != null && minute != null;
}