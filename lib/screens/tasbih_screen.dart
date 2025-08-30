// lib/screens/tasbih_screen.dart
import 'package:flutter/material.dart';
import '../services/storage_service.dart';

/// Plain data-model – unchanged
class Tasbih {
  final String id;
  final String title;
  final String arabicText;
  final String translation;
  final String transliteration;
  final String category;
  final int targetCount;
  final String recommendation;

  const Tasbih({
    required this.id,
    required this.title,
    required this.arabicText,
    required this.translation,
    required this.transliteration,
    required this.category,
    required this.targetCount,
    required this.recommendation,
  });
}

class TasbihScreen extends StatefulWidget {
  final StorageService storageService;

  const TasbihScreen({Key? key, required this.storageService}) : super(key: key);

  @override
  State<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen> {
  final List<Tasbih> _tasbihList = [
    /* ------------------------- 🌅 MORNING ------------------------- */
    Tasbih(
      id: 'm1',
      title: 'Subḥānallāh',
      arabicText: 'سُبْحَانَ اللَّهِ',
      translation: 'Glory be to Allah',
      transliteration: 'Subhan Allah',
      category: 'Morning',
      targetCount: 33,
      recommendation: 'After Fajr until sunrise',
    ),
    Tasbih(
      id: 'm2',
      title: 'Al-ḥamdu lillāh',
      arabicText: 'الْـحَمْدُ لِلَّهِ',
      translation: 'Praise be to Allah',
      transliteration: 'Alhamdu lillah',
      category: 'Morning',
      targetCount: 33,
      recommendation: 'After Fajr until sunrise',
    ),
    Tasbih(
      id: 'm3',
      title: 'Allāhu akbar',
      arabicText: 'اللَّهُ أَكْبَرُ',
      translation: 'Allah is the Greatest',
      transliteration: 'Allahu Akbar',
      category: 'Morning',
      targetCount: 34,
      recommendation: 'After Fajr until sunrise',
    ),
        Tasbih(
      id: 'm4',
      title: 'Astaghfirullāh',
      arabicText: 'أَسْتَغْفِرُ اللَّهَ',
      translation: 'I seek forgiveness from Allah',
      transliteration: 'Astaghfirullah',
      category: 'Morning',
      targetCount: 33,
      recommendation: 'After Fajr until sunrise',
    ),
    Tasbih(
      id: 'm5',
      title: 'Lā ilāha illā Allāh…',
      arabicText:
          'لَا إِلٰهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ، وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
      translation:
          'There is no god but Allah alone, with no partner; to Him belongs the kingdom and to Him is all praise, and He is over all things competent.',
      transliteration:
          'La ilaha illa Allah wahdahu la sharika lah, lahul mulku wa lahul hamd, wa huwa ʿala kulli shay’in qadir',
      category: 'Morning',
      targetCount: 100,
      recommendation: 'Recite 100 times after Fajr',
    ),

    Tasbih(
      id: 'm6',
      title: '',
      arabicText:
          'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ',
      translation:
          'In the name of Allah with whose name nothing on earth or in heaven can cause harm, and He is the All-Hearing, the All-Knowing.',
      transliteration:
          'Bismillah alladhi la yadurru maʿa ismihi shay’un fil-ardi wa-la fis-sama’ wa-huwas-Samiʿul-ʿAlim',
      category: 'Morning',
      targetCount: 3,
      recommendation: 'After Fajr until sunrise',
    ),

    /* ------------------------- 🌞 DAYTIME ------------------------- */
    Tasbih(
      id: 'd1',
      title: '',
      arabicText:
          'اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ',
      translation:
          'O Allah, send blessings and peace upon Muhammad and upon the family of Muhammad',
      transliteration:
          'Allahumma salli ʿala Muhammad wa ʿala ali Muhammad',
      category: 'Daytime',
      targetCount: 100,
      recommendation: 'Between Duḥā and ʿAṣr (minimum 10, best 100)',
    ),
    Tasbih(
      id: 'd2',
      title: 'Subḥānallāhi wa biḥamdih',
      arabicText: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ',
      translation: 'Glory be to Allah and with His praise',
      transliteration: 'Subhanallahi wa bihamdihi',
      category: 'Daytime',
      targetCount: 100,
      recommendation: 'Between Duḥā and ʿAṣr',
    ),
    Tasbih(
      id: 'd3',
      title: 'Lā ḥawla wa lā quwwata illā billāh',
      arabicText: 'لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ',
      translation: 'There is no power or strength except with Allah',
      transliteration: 'La hawla wa la quwwata illa billah',
      category: 'Daytime',
      targetCount: 100,
      recommendation: 'Between Duḥā and ʿAṣr',
    ),

    /* ------------------------- 🌇 EVENING ------------------------- */
    Tasbih(
      id: 'e1',
      title: 'Āyat al-Kursī',
      arabicText:
          'اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ ۗ مَنْ ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلَّا بِإِذْنِهِ ۚ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ ۖ وَلَا يُحِيطُونَ بِشَيْءٍ مِنْ عِلْمِهِ إِلَّا بِمَا شَاءَ ۚ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ ۖ وَلَا يَئُودُهُ حِفْظُهُمَا ۚ وَهُوَ الْعَلِيُّ الْعَظِيمُ',
      translation:
          '',
      transliteration: '',
      category: 'Evening',
      targetCount: 1,
      recommendation: 'Once after Maghrib until ʿIshāʾ',
    ),
    Tasbih(
      id: 'e2',
      title: 'Sūrat al-Ikhlāṣ',
      arabicText:
          'قُلْ هُوَ اللَّهُ أَحَدٌ ۝ اللَّهُ الصَّمَدُ ۝ لَمْ يَلِدْ وَلَمْ يُولَدْ ۝ وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ',
      translation: '',
      transliteration: '',
      category: 'Evening',
      targetCount: 3,
      recommendation: 'Three times after Maghrib',
    ),
    Tasbih(
      id: 'e3',
      title: 'Sūrat al-Falaq',
      arabicText:
          'قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ ۝ مِن شَرِّ مَا خَلَقَ ۝ وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ ۝ وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ ۝ وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ',
      translation: '',
      transliteration: '',
      category: 'Evening',
      targetCount: 3,
      recommendation: 'Three times after Maghrib',
    ),
    Tasbih(
      id: 'e4',
      title: 'Sūrat an-Nās',
      arabicText:
          'قُلْ أَعُوذُ بِرَبِّ النَّاسِ ۝ مَلِكِ النَّاسِ ۝ إِلٰهِ النَّاسِ ۝ مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ ۝ الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ ۝ مِنَ الْجِنَّةِ وَالنَّاسِ',
      translation: '',
      transliteration: '',
      category: 'Evening',
      targetCount: 3,
      recommendation: 'Three times after Maghrib',
    ),
    Tasbih(
      id: 'e5',
      title: '',
      arabicText:
          'حَسْبِيَ اللَّهُ لَا إِلٰهَ إِلَّا هُوَ عَلَيْهِ تَوَكَّلْتُ وَهُوَ رَبُّ الْعَرْشِ الْعَظِيمِ',
      translation:
          'Sufficient for me is Allah; there is no deity except Him. On Him I rely, and He is the Lord of the Mighty Throne.',
      transliteration:
          'Hasbiyallahu la ilaha illa huwa, ʿalayhi tawakkaltu wa huwa rabbul-ʿarsh il-ʿazim',
      category: 'Evening',
      targetCount: 7,
      recommendation: 'Seven times after Maghrib',
    ),

    /* ------------------------- 🌙 NIGHT ------------------------- */
    Tasbih(
      id: 'n1',
      title: 'Subḥānallāh',
      arabicText: 'سُبْحَانَ اللَّهِ',
      translation: 'Glory be to Allah',
      transliteration: 'Subhan Allah',
      category: 'Night',
      targetCount: 33,
      recommendation: 'Before sleep ',
    ),
    Tasbih(
      id: 'n2',
      title: ' Al-ḥamdu lillāh',
      arabicText: 'الْـحَمْدُ لِلَّهِ',
      translation: 'Praise be to Allah',
      transliteration: 'Alhamdu lillah',
      category: 'Night',
      targetCount: 33,
      recommendation: 'Before sleep ',
    ),
    Tasbih(
      id: 'n3',
      title: 'Allāhu akbar',
      arabicText: 'اللَّهُ أَكْبَرُ',
      translation: 'Allah is the Greatest',
      transliteration: 'Allahu Akbar',
      category: 'Night',
      targetCount: 34,
      recommendation: 'Before sleep ',
    ),
    Tasbih(
      id: 'n4',
      title: '',
      arabicText: 'اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ',
      translation: 'O Allah, send blessings upon Muhammad',
      transliteration: 'Allahumma salli ʿala Muhammad',
      category: 'Night',
      targetCount: 10,
      recommendation: 'Before sleep (minimum 10)',
    ),
    Tasbih(
      id: 'n5',
      title: '',
      arabicText:
          'أَسْتَغْفِرُ اللَّهَ الْعَظِيمَ الَّذِي لَا إِلٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ وَأَتُوبُ إِلَيْهِ',
      translation:
          'I seek the forgiveness of Allah the Mighty, there is no god but Him, the Ever-Living, the Sustainer, and I turn to Him in repentance.',
      transliteration:
          'Astaghfirullah al-ʿazim alladhi la ilaha illa huwa al-hayyu-l-qayyum wa atubu ilayh',
      category: 'Night',
      targetCount: 3,
      recommendation: 'Before sleep',
    ),
        Tasbih(
      id: 'n6',
      title: 'Sūrat al-Ikhlāṣ',
      arabicText:
          'قُلْ هُوَ اللَّهُ أَحَدٌ ۝ اللَّهُ الصَّمَدُ ۝ لَمْ يَلِدْ وَلَمْ يُولَدْ ۝ وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ',
      translation: '',
      transliteration: '',
      category: 'Night',
      targetCount: 1,
      recommendation: 'Once each before sleeping',
    ),

  Tasbih(
      id: 'n7',
      title: 'Sūrat al-Falaq',
      arabicText:
          'قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ ۝ مِن شَرِّ مَا خَلَقَ ۝ وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ ۝ وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ ۝ وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ',
      translation: '',
      transliteration: '',
      category: 'Night',
      targetCount: 1,
      recommendation: 'Once each before sleeping',
    ),
    Tasbih(
      id: 'n8',
      title: 'Sūrat an-Nās',
      arabicText:
          'قُلْ أَعُوذُ بِرَبِّ النَّاسِ ۝ مَلِكِ النَّاسِ ۝ إِلٰهِ النَّاسِ ۝ مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ ۝ الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ ۝ مِنَ الْجِنَّةِ وَالنَّاسِ',
      translation: '',
      transliteration: '',
      category: 'Night',
      targetCount: 1,
      recommendation: 'Once each before sleeping',
    ),
    /* ------------------------- 🌐 GENERAL ------------------------- */
    Tasbih(
      id: 'g1',
      title: '',
      arabicText:
          'اللَّهُمَّ صَلِّ وَسَلِّمْ عَلَى نَبِيِّنَا مُحَمَّد',
      translation:
          'O Allah, send blessings and peace upon our Prophet Muhammad',
      transliteration:
          'Allahumma salli wa sallim ala nabiyyina Muhammad',
      category: 'General',
      targetCount: 0,
      recommendation: 'Recite frequently, especially on Fridays',
    ),
    Tasbih(
      id: 'g2',
      title: 'Lā ilāha illā Allāh',
      arabicText: 'لَا إِلَهَ إِلَّا اللَّهُ',
      translation: 'There is no god but Allah',
      transliteration: 'La ilaha illa Allah',
      category: 'General',
      targetCount: 0,
      recommendation: 'Recite as much as possible throughout the day',
    ),
  ];

  /* =========================================================================
     2. CATEGORIES – now five time-slots + General
     ========================================================================= */
final List<String> _categories = [
    'All',
    'Morning',
    'Daytime',
    'Evening',
    'Night',
    'General',
  ];

  String _selectedCategory = 'All';

  /* =========================================================================
     Build – listens to storage box so screen reloads on every entry
     ========================================================================= */
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<dynamic>(
      valueListenable: widget.storageService.tasbihListenable,
      builder: (_, __, ___) {
        final savedCounters =
            Map<String, int>.from(widget.storageService.getTasbihCounters());
        final counters = <String, int>{};
        for (var t in _tasbihList) {
          counters[t.id] = savedCounters[t.id] ?? 0;
        }

        final filtered = _selectedCategory == 'All'
            ? _tasbihList
            : _tasbihList.where((t) => t.category == _selectedCategory).toList();

        return Scaffold(
          body: Column(
            children: [
              _buildCategorySelector(),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filtered.length,
                  itemBuilder: (_, i) =>
                      _buildTasbihCard(filtered[i], counters),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _resetAllCounters(),
            tooltip: 'Reset All Counters',
            child: const Icon(Icons.refresh),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        );
      },
    );
  }

  /* =========================================================================
     Category selector
     ========================================================================= */
  Widget _buildCategorySelector() => Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            itemBuilder: (_, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ChoiceChip(
                label: Text(_categories[index]),
                selected: _selectedCategory == _categories[index],
                onSelected: (sel) => setState(() =>
                    _selectedCategory = sel ? _categories[index] : 'All'),
                selectedColor: Theme.of(context).primaryColor,
                labelStyle: TextStyle(
                  color: _selectedCategory == _categories[index]
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ),
      );

  /* =========================================================================
     Single card builder
     ========================================================================= */
  Widget _buildTasbihCard(Tasbih t, Map<String, int> counters) {
    final count = counters[t.id] ?? 0;
    final progress = t.targetCount > 0 ? count / t.targetCount : 0.0;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    t.title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                if (t.targetCount > 0)
                  Chip(
                    label: Text('$count/${t.targetCount}'),
                    backgroundColor: progress >= 1
                        ? Colors.green.withOpacity(0.2)
                        : Theme.of(context).primaryColor.withOpacity(0.2),
                    labelStyle: TextStyle(
                      color: progress >= 1
                          ? Colors.green
                          : Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              t.arabicText,
              style: const TextStyle(fontSize: 22, height: 1.5),
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 12),
            Text(t.translation,
                style: TextStyle(fontSize: 16, color: Colors.grey[700])),
            const SizedBox(height: 8),
            Text(t.transliteration,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic)),
            if (t.targetCount > 0) ...[
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  progress >= 1 ? Colors.green : Theme.of(context).primaryColor,
                ),
                minHeight: 8,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.lightbulb_outline,
                      size: 16, color: Colors.blue[700]),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      t.recommendation,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue[700],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _incrementCounter(t.id),
                    icon: const Icon(Icons.add),
                    label: const Text('Count'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () => _resetCounter(t.id),
                  tooltip: 'Reset Counter',
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    padding: const EdgeInsets.all(12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /* =========================================================================
     Counter helpers
     ========================================================================= */



  void _resetAllCounters() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Reset All Counters'),
        content:
            const Text('Are you sure you want to reset all counters to zero?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              widget.storageService.resetTasbihCounters();
              Navigator.pop(context);
            },
            child: const Text('Reset All'),
          ),
        ],
      ),
    );
  }

    void _incrementCounter(String id) {
  final currentCounters = widget.storageService.getTasbihCounters();
  final current = currentCounters[id] ?? 0;
  final newCounters = Map<String, int>.from(currentCounters); // Create a copy
  newCounters[id] = current + 1;
  widget.storageService.saveTasbihCounters(newCounters);
}

void _resetCounter(String id) {
  final currentCounters = widget.storageService.getTasbihCounters();
  final newCounters = Map<String, int>.from(currentCounters); // Create a copy
  newCounters[id] = 0;
  widget.storageService.saveTasbihCounters(newCounters);
}
}