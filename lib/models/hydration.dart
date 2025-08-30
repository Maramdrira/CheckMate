import 'package:hive/hive.dart';

part 'hydration.g.dart';

@HiveType(typeId: 1)
class HydrationSettings extends HiveObject {
  @HiveField(0)
  int dailyGoal;
  
  @HiveField(1)
  int reminderInterval;
  
  @HiveField(2)
  DateTime lastReminderTime;
  
  @HiveField(3)
  int glassesConsumed;
  
  @HiveField(4)
  DateTime lastResetDate;
  
  @HiveField(5)
  List<DateTime> consumptionHistory;


  HydrationSettings({
    this.dailyGoal = 8,
    this.reminderInterval = 2,
    required this.lastReminderTime,
    this.glassesConsumed = 0,
    required this.lastResetDate,
    List<DateTime>? consumptionHistory,
  }) : consumptionHistory = consumptionHistory ?? [];

  // Reset consumption if it's a new day
  void checkAndResetDaily() {
    final now = DateTime.now();
    if (now.day != lastResetDate.day || 
        now.month != lastResetDate.month || 
        now.year != lastResetDate.year) {
      glassesConsumed = 0;
      consumptionHistory.clear();
      lastResetDate = now;
      save();
    }
  }

  void addGlass() {
    glassesConsumed++;
    consumptionHistory.add(DateTime.now());
    save();
  }

  void removeGlass() {
    if (glassesConsumed > 0) {
      glassesConsumed--;
      if (consumptionHistory.isNotEmpty) {
        consumptionHistory.removeLast();
      }
      save();
    }
  }

    void resetToday() {
    glassesConsumed = 0;
    consumptionHistory.clear();
    lastResetDate = DateTime.now();
    save();
  }

  double get progressPercentage {
    return dailyGoal > 0 ? (glassesConsumed / dailyGoal).clamp(0.0, 1.0) : 0.0;
  }

  bool get isGoalAchieved {
    return glassesConsumed >= dailyGoal;
  }
}