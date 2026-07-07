class WakeModel {
  /// Wake-up time selected by the user.
  /// Later this can come from:
  /// - User Profile
  /// - AI Recommendation
  /// - Smart Band
  /// - Sleep Detection

  final int hour;
  final int minute;

  const WakeModel({
    required this.hour,
    required this.minute,
  });

  /// Today's wake-up DateTime
  DateTime get wakeTime {
    final now = DateTime.now();

    return DateTime(
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
  }

  /// Total minutes after midnight.
  int get totalMinutes {
    return hour * 60 + minute;
  }

  /// Display as 12-hour format.
  String get formattedTime {
    int h = hour;
    final period = h >= 12 ? "PM" : "AM";

    h = h % 12;
    if (h == 0) h = 12;

    final m = minute.toString().padLeft(2, '0');

    return "$h:$m $period";
  }

  @override
  String toString() {
    return formattedTime;
  }
}