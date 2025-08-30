import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/task.dart';
import '../models/hydration.dart';
import '../models/prayer.dart';

class StorageService {
  final Box<Task> taskBox;
  final Box<HydrationSettings> hydrationBox;
  final Box<PrayerTime> prayerBox;
  final Box<Map<dynamic, dynamic>> tasbihBox;

  StorageService({
    required this.taskBox,
    required this.hydrationBox,
    required this.prayerBox,
    required this.tasbihBox,
  });

  // Task methods
  List<Task> getTasks() {
    return taskBox.values.toList();
  }

  void addTask(Task task) {
    taskBox.add(task);
  }

  void updateTask(Task task) {
    task.save();
  }

  void deleteTask(Task task) {
    task.delete();
  }

  // Hydration methods
  HydrationSettings getHydrationSettings() {
    if (hydrationBox.isEmpty) {
      final now = DateTime.now();
      final settings = HydrationSettings(
        lastReminderTime: now,
        lastResetDate: DateTime(now.year, now.month, now.day),
        consumptionHistory: [],
      );
      hydrationBox.add(settings);
      return settings;
    }
    final settings = hydrationBox.getAt(0)!;
    settings.checkAndResetDaily();
    return settings;
  }

  void updateHydrationSettings(HydrationSettings settings) {
    settings.save();
  }

  void addWaterGlass() {
    final settings = getHydrationSettings();
    settings.addGlass();
  }

  void removeWaterGlass() {
    final settings = getHydrationSettings();
    settings.removeGlass();
  }

  // Prayer methods - SIMPLIFIED
  List<PrayerTime> getPrayerTimes() {
    if (prayerBox.isEmpty) {
      _initializePrayers();
    }
    return prayerBox.values.toList();
  }

  void _initializePrayers() {
    // Do NOT clear the box here – otherwise we lose saved flags
    final prayers = [
      PrayerTime(name: 'Fajr', isCompleted: false),
      PrayerTime(name: 'Dhuhr', isCompleted: false),
      PrayerTime(name: 'Asr', isCompleted: false),
      PrayerTime(name: 'Maghrib', isCompleted: false),
      PrayerTime(name: 'Isha', isCompleted: false),
    ];

    for (final p in prayers) {
      prayerBox.add(p);
    }
  }

  void resetPrayerTimes() {
    prayerBox.clear(); // wipe everything
    _initializePrayers(); // re-add five fresh, unchecked items
  }

  void togglePrayerCompletion(PrayerTime prayer) {
    prayer.toggleCompletion(); // This calls save() internally
  }

  // ============ TASBIH COUNTER METHODS ============

  Map<String, int> getTasbihCounters() {
    final raw = tasbihBox.get('counters');
    if (raw == null) return <String, int>{};

    // Convert any type of map to Map<String, int>
    final Map<dynamic, dynamic> dynamicMap = Map<dynamic, dynamic>.from(raw);

    final Map<String, int> result = {};
    dynamicMap.forEach((key, value) {
      if (key is String && value is int) {
        result[key] = value;
      } else if (key is String && value is num) {
        result[key] = value.toInt();
      }
      // Handle other cases if needed
    });

    return result;
  }

  void saveTasbihCounters(Map<String, int> counters) {
    // Convert to Map<String, dynamic> explicitly
    tasbihBox.put('counters', Map<String, dynamic>.from(counters));
  }

  void resetTasbihCounters() {
    tasbihBox.put('counters', <String, dynamic>{});
  }

  static Future<StorageService> create() async {
    final taskBox = await Hive.openBox<Task>('tasks');
    final hydrationBox = await Hive.openBox<HydrationSettings>('hydration');
    final prayerBox = await Hive.openBox<PrayerTime>('prayers');
    final tasbihBox = await Hive.openBox<Map<dynamic, dynamic>>('tasbih');

    // Initialize with empty map if needed
    if (!tasbihBox.containsKey('counters')) {
      tasbihBox.put('counters', <String, int>{});
    }

    return StorageService(
      taskBox: taskBox,
      hydrationBox: hydrationBox,
      prayerBox: prayerBox,
      tasbihBox: tasbihBox,
    );
  }

  // FIXED: Changed the return type to match the new tasbihBox type
  ValueListenable<Box<Map<dynamic, dynamic>>> get tasbihListenable =>
      tasbihBox.listenable();

   void resetWaterToday() {
    final box = Hive.box<HydrationSettings>('hydration');
    if (box.isEmpty) return;
    box.getAt(0)!.resetToday();   // uses the helper above
  }

}
