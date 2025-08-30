import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/storage_service.dart';
import '../widgets/category_selector.dart';

class AddTaskScreen extends StatefulWidget {
  final StorageService storageService;

  const AddTaskScreen({super.key, required this.storageService});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  bool _isArabic = false; // toggle for translation

  Map<String, dynamic> _selectedCategory = {
    'name': 'Study',
    'emoji': '📚',
    'color': const Color(0xFFADD8E6)
  };

  // Translation map
  final Map<String, String> _arabicTranslations = {
    'Study': 'الدراسة',
    'Work': 'العمل',
    'Planning': 'التخطيط',
    'Meetings': 'الاجتماعات',
    'Networking': 'التواصل',
    'Side Projects': 'المشاريع الجانبية',
    'Sport': 'الرياضة',
    'Meditation': 'التأمل',
    'Learning Languages': 'تعلم اللغات',
    'Read Qur’an': 'قراءة القرآن',
    'Memorize Qur’an': 'حفظ القرآن',
    'Household Chores': 'الأعمال المنزلية',
    'Cleaning': 'التنظيف',
    'Family Time': 'وقت العائلة',
    'Shopping': 'التسوق',
    'Nutrition & Cooking': 'التغذية والطبخ',
    'Gardening': 'البستنة',
    'Reading': 'القراءة',
    'Art & Creativity': 'الفن والإبداع',
    'Gaming': 'الألعاب',
    'Writing': 'الكتابة',
    'Volunteering': 'التطوع',
    'Watching Films': 'مشاهدة الأفلام',
  };

  final List<Map<String, dynamic>> _categories = [
    // Productivity
    {'name': 'Study', 'emoji': '📚', 'color': const Color(0xFFADD8E6)},
    {'name': 'Work', 'emoji': '💼', 'color': const Color(0xFF4682B4)},
    {'name': 'Planning', 'emoji': '📅', 'color': const Color(0xFFFFD700)},
    {'name': 'Meetings', 'emoji': '📞', 'color': const Color(0xFFFAFAD2)},
    {'name': 'Networking', 'emoji': '🤝', 'color': const Color(0xFFB0E0E6)},
    {'name': 'Side Projects', 'emoji': '🛠️', 'color': const Color(0xFF87CEEB)},

    // Personal Growth
    {'name': 'Sport', 'emoji': '🏃‍♂️', 'color': const Color(0xFF90EE90)},
    {'name': 'Meditation', 'emoji': '🧘', 'color': const Color(0xFF00CED1)},
    {'name': 'Learning Languages', 'emoji': '🗣️', 'color': const Color(0xFF4169E1)},
    {'name': 'Read Qur’an', 'emoji': '📖', 'color': const Color(0xFF2E8B57)},
    {'name': 'Memorize Qur’an', 'emoji': '🕌', 'color': const Color(0xFF006400)},

    // Home & Family
    {'name': 'Household Chores', 'emoji': '🧹', 'color': const Color(0xFF98FB98)},
    {'name': 'Cleaning', 'emoji': '🧼', 'color': const Color(0xFFF08080)},
    {'name': 'Family Time', 'emoji': '👨‍👩‍👧‍👦', 'color': const Color(0xFFFFDAB9)},
    {'name': 'Shopping', 'emoji': '🛒', 'color': const Color(0xFFFF8C00)},
    {'name': 'Nutrition & Cooking', 'emoji': '🍽️', 'color': const Color(0xFFFA8072)},
    {'name': 'Gardening', 'emoji': '🌱', 'color': const Color(0xFF228B22)},

    // Leisure
    {'name': 'Reading', 'emoji': '📖', 'color': const Color(0xFFFFA07A)},
    {'name': 'Art & Creativity', 'emoji': '🎨', 'color': const Color(0xFFFF69B4)},
    {'name': 'Gaming', 'emoji': '🎮', 'color': const Color(0xFF32CD32)},
    {'name': 'Writing', 'emoji': '✍️', 'color': const Color(0xFFFF6347)},
    {'name': 'Volunteering', 'emoji': '🤲', 'color': const Color(0xFF87CEFA)},
    {'name': 'Watching Films', 'emoji': '🎬', 'color': const Color(0xFF8B4513)},
  ];

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _submitTask() {
    if (_formKey.currentState!.validate()) {
      final newTask = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        createdAt: DateTime.now(),
        category: _selectedCategory['name'],
        emoji: _selectedCategory['emoji'],
        colorValue: _selectedCategory['color'].value,
      );

      widget.storageService.addTask(newTask);
      Navigator.pop(context);
    }
  }

  String _getCategoryName(String name) {
    if (_isArabic) {
      return _arabicTranslations[name] ?? name;
    }
    return name;
  }

  @override
  Widget build(BuildContext context) {
    // apply translation before passing to selector
    final translatedCategories = _categories
        .map((cat) => {
              'name': _getCategoryName(cat['name']),
              'emoji': cat['emoji'],
              'color': cat['color'],
            })
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(_isArabic ? 'إضافة مهمة جديدة' : 'Add New Task'),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              setState(() {
                _isArabic = !_isArabic;
              });
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: _isArabic ? 'عنوان المهمة' : 'Task Title',
                  border: const OutlineInputBorder(),
                ),
                textDirection: _isArabic ? TextDirection.rtl : TextDirection.ltr,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return _isArabic
                        ? 'يرجى إدخال عنوان المهمة'
                        : 'Please enter a task title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CategorySelector(
                categories: translatedCategories,
                selectedCategory: _selectedCategory,
                onCategorySelected: (category) {
                  setState(() {
                    _selectedCategory = category;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitTask,
                child: Text(_isArabic ? 'إضافة' : 'Add Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
