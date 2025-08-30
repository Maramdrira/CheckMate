import 'package:hive/hive.dart';

part 'prayer.g.dart';

@HiveType(typeId: 2)
class PrayerTime extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(2)
  bool isCompleted;

  PrayerTime({
    required this.name,
    this.isCompleted = false,
  });

  void toggleCompletion() {
    isCompleted = !isCompleted;
    save(); // This should persist the change
  }
}