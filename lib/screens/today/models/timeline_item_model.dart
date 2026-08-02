import 'activity_model.dart';

enum TimelineItemType {
  header,
  activity,
}

class TimelineItem {
  final TimelineItemType type;

  final String title;

  final ActivityModel? activity;

  const TimelineItem.header({
    required this.title,
  })  : type = TimelineItemType.header,
        activity = null;

  const TimelineItem.activity({
    required this.activity,
  })  : type = TimelineItemType.activity,
        title = "";

  bool get isHeader =>
      type == TimelineItemType.header;

  bool get isActivity =>
      type == TimelineItemType.activity;
}