import 'activity_model.dart';

class RhythmModel {
  final String id;

  final String name;

  final int startHour;

  final int endHour;

  final List<ActivityModel> activities;

  const RhythmModel({
    required this.id,
    required this.name,
    required this.startHour,
    required this.endHour,
    required this.activities,
  });
}