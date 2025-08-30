import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wings_and_things/models/prayer.dart';
import 'package:wings_and_things/services/storage_service.dart';
import '../models/hydration.dart';
import '../models/task.dart';
import '../services/LanguageService.dart';

class PrayerScreen extends StatefulWidget {
  const PrayerScreen({super.key});

  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> {
  late StorageService storageService;

  @override
  void initState() {
    super.initState();
    storageService = StorageService(
      taskBox: Hive.box<Task>('tasks'),
      hydrationBox: Hive.box<HydrationSettings>('hydration'),
      prayerBox: Hive.box<PrayerTime>('prayers'),
      tasbihBox: Hive.box<Map<dynamic, dynamic>>('tasbih'),
    );
    storageService.getPrayerTimes();
  }
String _arabicPrayerName(String name) {
  switch (name) {
    case 'Fajr':
      return 'الفجر';
    case 'Dhuhr':
      return 'الظهر';
    case 'Asr':
      return 'العصر';
    case 'Maghrib':
      return 'المغرب';
    case 'Isha':
      return 'العشاء';
    default:
      return name;
  }
}

  void _togglePrayerCompletion(PrayerTime prayer) => prayer.toggleCompletion();

  void _resetPrayers() {
    storageService.resetPrayerTimes();
  }

  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);

    return Directionality(
      textDirection: languageService.direction,
      child: ValueListenableBuilder<Box<PrayerTime>>(
        valueListenable: Hive.box<PrayerTime>('prayers').listenable(),
        builder: (_, box, __) {
          final prayers = box.values.toList();
          final completed = prayers.where((p) => p.isCompleted).length;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  languageService.tr(
                      'Completed: $completed/${prayers.length}',
                      arabic: 'مكتمل: $completed/${prayers.length}'),
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                LinearProgressIndicator(
                  value: prayers.isEmpty ? 0 : completed / prayers.length,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: prayers.length,
                    itemBuilder: (_, i) =>
                        _buildPrayerCard(context, prayers[i], languageService),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _resetPrayers,
                    child: Text(languageService.tr(
                        'Reset Prayers', arabic: 'إعادة تعيين الصلوات')),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPrayerCard(
      BuildContext context, PrayerTime prayer, LanguageService lang) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: prayer.isCompleted
                ? Colors.green.withOpacity(0.2)
                : theme.primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: prayer.isCompleted ? Colors.green : theme.primaryColor,
              width: 2,
            ),
          ),
          child: Icon(
            prayer.isCompleted ? Icons.check : Icons.access_time,
            color: prayer.isCompleted ? Colors.green : theme.primaryColor,
            size: 20,
          ),
        ),
        title: Text(
  lang.tr(
    prayer.name,
    arabic: _arabicPrayerName(prayer.name)),


          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            decoration:
                prayer.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Checkbox(
          value: prayer.isCompleted,
          onChanged: (_) => _togglePrayerCompletion(prayer),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          activeColor: theme.primaryColor,
        ),
      ),
    );
  }
}
