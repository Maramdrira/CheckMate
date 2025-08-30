import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wings_and_things/models/hydration.dart';
import 'package:wings_and_things/services/storage_service.dart';
import 'package:wings_and_things/widgets/hydration_tracker.dart';
import '../models/prayer.dart';
import '../models/task.dart';
import '../services/LanguageService.dart';

class HydrationScreen extends StatefulWidget {
  const HydrationScreen({super.key});

  @override
  State<HydrationScreen> createState() => _HydrationScreenState();
}

class _HydrationScreenState extends State<HydrationScreen> {
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
  }

  void _resetWater() {
    setState(() {
      storageService.resetWaterToday();
    });
  }

  void _addGlass() {
    setState(() {
      storageService.addWaterGlass();
    });

    
  }

  void _removeGlass() {
    setState(() {
      storageService.removeWaterGlass();
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);

    return Directionality(
      textDirection: languageService.direction,
      child: ValueListenableBuilder(
        valueListenable: Hive.box<HydrationSettings>('hydration').listenable(),
        builder: (context, Box<HydrationSettings> box, widget) {
          final settings = box.isNotEmpty
              ? box.getAt(0)!
              : HydrationSettings(
                  lastReminderTime: DateTime.now(),
                  lastResetDate: DateTime.now(),
                );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                HydrationTracker(
                  settings: settings,
                  onAddGlass: _addGlass,
                  onRemoveGlass: _removeGlass,
                ),
                const SizedBox(height: 20),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          languageService.tr('Settings', arabic: 'الإعدادات'),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 10),
                        _buildSettingRow(
                          languageService.tr('Daily Goal', arabic: 'الهدف اليومي'),
                          '${settings.dailyGoal} ${languageService.tr('glasses', arabic: 'كؤوس')}',
                          () => _showGoalDialog(context, settings),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.refresh),
                    label: Text(languageService.tr('Reset Today', arabic: 'إعادة تعيين اليوم')),
                    onPressed: _resetWater,
                  ),
                ),
                const SizedBox(height: 450),
                Center(
                  child: Text(
                    languageService.tr(
                      '"Stay hydrated, stay focused."',
                      arabic: '"ابقَ رطبًا، وركز انتباهك."',
                    ),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[600],
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSettingRow(String title, String value, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      subtitle: Text(value),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }

  void _showGoalDialog(BuildContext context, HydrationSettings settings) {
    final languageService = Provider.of<LanguageService>(context, listen: false);
    int newGoal = settings.dailyGoal;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(languageService.tr('Set Daily Goal', arabic: 'تعيين الهدف اليومي')),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Slider(
                    value: newGoal.toDouble(),
                    min: 1,
                    max: 20,
                    divisions: 19,
                    label: newGoal.toString(),
                    onChanged: (value) {
                      setState(() {
                        newGoal = value.toInt();
                      });
                    },
                  ),
                  Text('$newGoal ${languageService.tr('glasses', arabic: 'كؤوس')}'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(languageService.tr('Cancel', arabic: 'إلغاء')),
                ),
                TextButton(
                  onPressed: () {
                    settings.dailyGoal = newGoal;
                    settings.save();
                    Navigator.pop(context);
                  },
                  child: Text(languageService.tr('Save', arabic: 'حفظ')),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
