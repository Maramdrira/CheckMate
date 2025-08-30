import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wings_and_things/screens/tasbih_screen.dart';
import 'package:wings_and_things/services/storage_service.dart';
import 'package:wings_and_things/screens/add_task_screen.dart';
import 'package:wings_and_things/screens/douaa_screen.dart';
import 'package:wings_and_things/screens/hydration_screen.dart';
import 'package:wings_and_things/screens/prayer_screen.dart';
import 'package:wings_and_things/screens/theme_selector_screen.dart';
import 'package:wings_and_things/widgets/task_tile.dart';
import 'package:wings_and_things/widgets/custom_bottom_nav.dart';

import '../models/task.dart';
import 'package:wings_and_things/widgets/theme_background.dart';
import '../services/LanguageService.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late Future<StorageService> _storageServiceFuture;

  @override
  void initState() {
    super.initState();
    _storageServiceFuture = StorageService.create();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final languageService = Provider.of<LanguageService>(context);

    return Directionality(
      textDirection: languageService.direction,
      child: FutureBuilder<StorageService>(
        future: _storageServiceFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(color: theme.primaryColor),
              ),
            );
          }

          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text(languageService.tr(
                  'Error: ${snapshot.error}',
                  arabic: 'خطأ: ${snapshot.error}',
                )),
              ),
            );
          }

          final storageService = snapshot.data!;
          final List<Widget> _screens = [
            TaskListScreen(storageService: storageService),
            const DouaaScreen(),
            TasbihScreen(storageService: storageService),
            const HydrationScreen(),
            const PrayerScreen(),
          ];

          return Scaffold(
            appBar: AppBar(
              title: Text(
                languageService.tr('CheckMate', arabic: 'رفيق المهام'),
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
              centerTitle: true,
              elevation: 0,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(24)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      theme.primaryColor.withOpacity(0.9),
                      theme.primaryColor.withOpacity(0.7),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: theme.primaryColor.withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
              ),
              foregroundColor: theme.colorScheme.onPrimary,
              shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(14)),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.palette),
                  tooltip: languageService.tr(
                      'Change Theme', arabic: 'تغيير الثيم'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ThemeSelectorScreen(),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.language),
                  tooltip: languageService.tr('Change Language', arabic: 'تغيير اللغة'),
                  onPressed: () {
                    languageService.toggleLanguage();
                  },
                )
              ],
            ),
            body: ThemeBackground(child: _screens[_selectedIndex]),
            bottomNavigationBar: CustomBottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              theme: theme,
            ),
            floatingActionButton: _selectedIndex == 0
                ? FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddTaskScreen(
                            storageService: storageService,
                          ),
                        ),
                      );
                    },
                    child: const Icon(Icons.add),
                    backgroundColor: theme.primaryColor,
                    foregroundColor: theme.appBarTheme.foregroundColor,
                  )
                : null,
          );
        },
      ),
    );
  }
}

class TaskListScreen extends StatelessWidget {
  final StorageService storageService;

  const TaskListScreen({super.key, required this.storageService});

  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);
    return ValueListenableBuilder(
      valueListenable: Hive.box<Task>('tasks').listenable(),
      builder: (context, Box<Task> box, widget) {
        final tasks = box.values.toList();

        if (tasks.isEmpty) {
          return Center(
            child: Text(
              languageService.tr(
                'No tasks yet!\nTap the + button to add one.',
                arabic: 'لا توجد مهام بعد!\nاضغط على زر + لإضافة مهمة.',
              ),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return TaskTile(
              task: task,
              onDelete: () {
                task.delete();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      languageService.tr('Task deleted', arabic: 'تم حذف المهمة'),
                    ),
                    action: SnackBarAction(
                      label: languageService.tr('Undo', arabic: 'تراجع'),
                      onPressed: () {
                        box.add(task);
                      },
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
