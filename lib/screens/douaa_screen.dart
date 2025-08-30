import 'package:flutter/material.dart';
import '../models/douaa.dart';

class DouaaScreen extends StatefulWidget {
  const DouaaScreen({Key? key}) : super(key: key);

  @override
  _DouaaScreenState createState() => _DouaaScreenState();
}

class _DouaaScreenState extends State<DouaaScreen> {
  final List<Douaa> _duas = [
  Douaa(
      id: '1',
      title: 'دعاء الاستيقاظ من النوم',
      arabicText: 'الْحَمْدُ لِلَّهِ الَّذِي أَحْيَانَا بَعْدَ مَا أَمَاتَنَا وَإِلَيْهِ النُّشُورُ',
      translation: 'Praise is to Allah who gave us life after having taken it from us and unto Him is the resurrection.',
      transliteration: 'Alhamdu lillahil-lathee ahyana baAAda ma amatana wa-ilayhin-nushoor.',
      category: 'Morning',
    ),
    Douaa(
      id: '3',
      title: 'دعاء الخروج من البيت',
      arabicText: 'بِسْمِ اللَّهِ، تَوَكَّلْتُ عَلَى اللَّهِ، وَلَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ',
      translation: 'In the name of Allah, I place my trust in Allah, and there is no might nor power except with Allah.',
      transliteration: 'Bismillahi, tawakkaltu AAalallah, wa la hawla wa la quwwata illa billah.',
      category: 'Home',
    ),
    Douaa(
      id: '4',
      title: 'دعاء دخول البيت',
      arabicText: 'بِسْمِ اللَّهِ وَلَجْنَا، وَبِسْمِ اللَّهِ خَرَجْنَا، وَعَلَى رَبِّنَا تَوَكَّلْنَا',
      translation: 'In the name of Allah we enter, in the name of Allah we leave, and upon our Lord we depend.',
      transliteration: 'Bismillahi walajna, wa bismillahi kharajna, wa AAala rabbina tawakkalna.',
      category: 'Home',
    ),
    Douaa(
      id: '6',
      title: 'دعاء دخول المسجد',
      arabicText: 'اللَّهُمَّ افْتَحْ لِي أَبْوَابَ رَحْمَتِكَ',
      translation: 'O Allah, open for me the doors of Your mercy.',
      transliteration: 'Allahumma iftah lee abwaba rahmatik.',
      category: 'Prayer',
    ),
    Douaa(
      id: '7',
      title: 'دعاء الخروج من المسجد',
      arabicText: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ مِنْ فَضْلِكَ',
      translation: 'O Allah, I ask You from Your favor.',
      transliteration: 'Allahumma innee as-aluka min fadlik.',
      category: 'Prayer',
    ),
    Douaa(
      id: '5',
      title: 'دعاء بعد السلام من الصلاة',
      arabicText: 'اللَّهُمَّ أَنْتَ السَّلَامُ وَمِنْكَ السَّلَامُ، تَبَارَكْتَ يَا ذَا الْجَلَالِ وَالْإِكْرَامِ',
      translation: 'O Allah, You are As-Salam and from You is all peace. Blessed are You, O Possessor of majesty and honor.',
      transliteration: 'Allahumma antas-salam wa minkas-salam, tabarakta ya thal-jalali wal-ikram.',
      category: 'Prayer',
    ),
    Douaa(
      id: '8',
      title: 'دعاء الركوب',
      arabicText: 'سُبْحَانَ الَّذِي سَخَّرَ لَنَا هَذَا وَمَا كُنَّا لَهُ مُقْرِنِينَ وَإِنَّا إِلَى رَبِّنَا لَمُنْقَلِبُونَ',
      translation: 'Glory to Him who has subjected this to us, and we could never have it (by our efforts). And indeed, to our Lord we will return.',
      transliteration: 'Subhanallathee sakhkhara lana hatha wa ma kunna lahu muqrineen, wa inna ila rabbina lamunqaliboon.',
      category: 'Travel',
    ),
    Douaa(
      id: '9',
      title: 'دعاء النوم',
      arabicText: 'بِاسْمِكَ اللَّهُمَّ أَمُوتُ وَأَحْيَا',
      translation: 'In Your name, O Allah, I die and I live.',
      transliteration: 'Bismika allahumma amootu wa ahya.',
      category: 'Sleep',
    ),
    Douaa(
      id: '10',
      title: 'دعاء الخوف والهم',
      arabicText: 'حَسْبِيَ اللَّهُ لَا إِلَهَ إِلَّا هُوَ، عَلَيْهِ تَوَكَّلْتُ وَهُوَ رَبُّ الْعَرْشِ الْعَظِيمِ',
      translation: 'Sufficient for me is Allah; there is no deity except Him. On Him I have relied, and He is the Lord of the Great Throne.',
      transliteration: 'Hasbiyallahu la ilaha illa huwa, alayhi tawakkaltu wa huwa rabbul-arshil-azeem.',
      category: 'Protection',
    ),
    // Newly added duas
    Douaa(
      id: '11',
      title: 'دعاء الاستخارة',
      arabicText: 'اللَّهُمَّ إِنِّي أَسْتَخِيرُكَ بِعِلْمِكَ، وَأَسْتَقْدِرُكَ بِقُدْرَتِكَ، وَأَسْأَلُكَ مِنْ فَضْلِكَ الْعَظِيمِ، فَإِنَّكَ تَقْدِرُ وَلا أَقْدِرُ، وَتَعْلَمُ وَلا أَعْلَمُ، وَأَنْتَ عَلاَّمُ الْغُيُوبِ، اللَّهُمَّ إِنْ كُنْتَ تَعْلَمُ أَنَّ هَذَا الأَمْرَ خَيْرٌ لِي فِي دِينِي وَمَعَاشِي وَعَاقِبَةِ أَمْرِي، فَاقْدُرْهُ لِي وَيَسِّرْهُ لِي ثُمَّ بَارِكْ لِي فِيهِ، وَإِنْ كُنْتَ تَعْلَمُ أَنَّ هَذَا الأَمْرَ شَرٌّ لِي فِي دِينِي وَمَعَاشِي وَعَاقِبَةِ أَمْرِي، فَاصْرِفْهُ عَنِّي وَاصْرِفْنِي عَنْهُ، وَاقْدُرْ لِي الْخَيْرَ حَيْثُ كَانَ ثُمَّ أَرْضِنِي بِهِ',
      translation: 'O Allah, I seek Your guidance by virtue of Your knowledge, and I seek ability by virtue of Your power, and I ask You of Your great bounty. You are able and I am not. You know and I know not, and You are the Knower of hidden things. O Allah, if You know that this matter is good for me in my religion, my livelihood and my affairs, then ordain it for me, make it easy for me, and bless it for me. And if You know that this matter is bad for me in my religion, my livelihood and my affairs, then turn me away from it, and turn it away from me, and ordain for me the good wherever it may be and make me pleased with it.',
      transliteration: '.',
      category: 'Guidance',
    ),
    Douaa(
      id: '12',
      title: 'دعاء الامتحان',
      arabicText: 'اللَّهُمَّ لا سَهْلَ إِلا مَا جَعَلْتَهُ سَهْلاً، وَأَنْتَ تَجْعَلُ الْحَزْنَ إِذَا شِئْتَ سَهْلاً',
      translation: 'O Allah, there is no ease except in what You have made easy, and You make the difficulty, if You wish, easy.',
      transliteration: 'Allahumma la sahla illa ma ja\'altahu sahla, wa anta taj\'alul-hazna idha shi\'ta sahla.',
      category: 'Study',
    ),
    Douaa(
      id: '13',
      title: 'دعاء الحفظ والوقاية',
      arabicText: 'وَجَعَلْنَا مِن بَيْنِ أَيْدِيهِمْ سَدًّا وَمِنْ خَلْفِهِمْ سَدًّا فَأَغْشَيْنَاهُمْ فَهُمْ لَا يُبْصِرُونَ',
      translation: 'And We have put a barrier before them and a barrier behind them and covered them, so they do not see.',
      transliteration: 'Waja\'alna min bayni aydeehim saddan wamin khalfihim saddan faaghshaynahum fahum la yubsiroon',
      category: 'Protection',
    ),
    Douaa(
      id: '14',
      title: 'دعاء التحصين',
      arabicText: 'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ',
      translation: 'I seek refuge in the perfect words of Allah from the evil of what He has created.',
      transliteration: 'A\'oothu bikalimaatil-laahit-taammaati min sharri maa khalaq',
      category: 'Protection',
    ),
    Douaa(
      id: '15',
      title: 'دعاء الحسد والعين',
      arabicText: 'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّةِ، مِنْ كُلِّ شَيْطَانٍ وَهَامَّةٍ، وَمِنْ كُلِّ عَيْنٍ لاَمَّةٍ',
      translation: 'I seek refuge in the perfect words of Allah from every devil and poisonous pest, and from every evil eye.',
      transliteration: 'A\'oothu bikalimaatil-laahit-taammati min kulli shaytaanin wa haammatin wa min kulli \'aynin laammatin',
      category: 'Protection',
    ),
    Douaa(
      id: '16',
      title: 'دعاء النوم',
      arabicText: 'بِاسْمِكَ رَبِّي وَضَعْتُ جَنْبِي، وَبِكَ أَرْفَعُهُ، إِنْ أَمْسَكْتَ نَفْسِي فَارْحَمْهَا، وَإِنْ أَرْسَلْتَهَا فَاحْفَظْهَا بِمَا تَحْفَظُ بِهِ عِبَادَكَ الصَّالِحِينَ',
      translation: 'In Your name my Lord, I lie down and in Your name I rise, so if You should take my soul then have mercy upon it, and if You should return my soul then protect it in the manner You do so with Your righteous servants.',
      transliteration: 'Bismika rabbee wada\'tu janbee, wa bika arfa\'uh, in amsakta nafsee farhamha, wa in arsaltaha fahfathha bima tahfathu bihi \'ibadakas-saliheen',
      category: 'Sleep',
    ),
    Douaa(
      id: '17',
      title: 'دعاء الحفظ من الشر',
      arabicText: 'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ',
      translation: 'In the name of Allah, with whose name nothing on earth or in heaven can cause harm, and He is the All-Hearing, the All-Knowing.',
      transliteration: 'Bismillah alladhi la yadurru ma\'a ismihi shay\'un fil-ardi wa la fis-sama\'i wa huwas-sami\'ul-\'alim',
      category: 'Protection',
    ),
    Douaa(
      id: '18',
      title: 'دعاء طلب العلم النافع',
      arabicText: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ عِلْمًا نَافِعًا، وَرِزْقًا طَيِّبًا، وَعَمَلًا مُتَقَبَّلًا',
      translation: 'O Allah, I ask You for beneficial knowledge, goodly provision, and acceptable deeds.',
      transliteration: 'Allahumma inni as\'aluka \'ilman nafi\'an, wa rizqan tayyiban, wa \'amalan mutaqabbalan',
      category: 'Study',
    ),
    Douaa(
      id: '19',
      title: 'تسبيح الله تعالى',
      arabicText: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ، عَدَدَ خَلْقِهِ، وَرِضَا نَفْسِهِ، وَزِنَةَ عَرْشِهِ، وَمِدَادَ كَلِمَاتِهِ',
      translation: 'Glory is to Allah and praise is to Him, by the multitude of His creation, by His Pleasure, by the weight of His Throne, and by the extent of His Words.',
      transliteration: 'Subhanallahi wa bihamdihi, \'adada khalqihi, wa ridha nafsihi, wa zinata \'arshihi, wa midada kalimatihi',
      category: 'Protection',
    ),
    Douaa(
      id: '20',
      title: 'دعاء السكينة والطمأنينة',
      arabicText: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ سَكِينَةً تَنْزِلُ مِنْ غَيْمٍ، وَقُرَّةَ عَيْنٍ فِي الصَّبْرِ، وَالرِّضَا بِالْقَضَاءِ',
      translation: 'O Allah, I ask You for tranquility that descends from the clouds, coolness of eyes in patience, and contentment with the decree.',
      transliteration: 'Allahumma inni as\'aluka sakeenatan tanzilu min ghaymin, wa qurrata \'aynin fis-sabri, war-rida bil-qada\'',
      category: 'Protection',
    ),
    Douaa(
      id: '21',
      title: 'دعاء الاستغفار والتوبة',
      arabicText: 'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ لَكَ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ',
      translation: 'O Allah, You are my Lord, there is no god but You. You created me and I am Your servant, and I am faithful to my covenant and my promise to You as much as I can. I seek refuge in You from the evil of what I have done. I acknowledge Your favor upon me and I acknowledge my sin, so forgive me, for surely none can forgive sins except You.',
      transliteration: '',
      category: 'Protection',
    ),
    Douaa(
      id: '2',
      title: 'دعاء الصباح',
      arabicText: 'اللَّهُمَّ إِنِّي أَصْبَحْتُ أُشْهِدُكَ، وَأُشْهِدُ حَمَلَةَ عَرْشِكَ، وَمَلَائِكَتَكَ، وَجَمِيعَ خَلْقِكَ، أَنَّكَ أَنْتَ اللَّهُ لَا إِلَهَ إِلَّا أَنْتَ وَحْدَكَ لَا شَرِيكَ لَكَ، وَأَنَّ مُحَمَّدًا عَبْدُكَ وَرَسُولُكَ',
      translation: 'O Allah, I have reached the morning and call on You, and on the bearers of Your Throne, on Your angels, and on all Your creation, to bear witness that surely You are Allah, there is no god but You alone, with no partner, and that Muhammad is Your servant and Your messenger.',
      transliteration: 'Allahumma inni asbahtu ushhiduka, wa ushhidu hamalata \'arshika, wa malaa\'ikataka, wa jamee\'a khalqika, annaka antallahu la ilaha illa anta wahdaka la shareeka laka, wa anna Muhammadan \'abduka wa rasooluka',
      category: 'Morning',
    ),  ];


  final List<String> _categories = [
    'All',
    'Morning',
    'Sleep',
    'Study',
    'Protection',
    'Home',
    'Prayer',
    'Travel',
    'Guidance',

  ];

  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final filteredDuas = _selectedCategory == 'All'
        ? _duas
        : _duas.where((douaa) => douaa.category == _selectedCategory).toList();

    return Scaffold(
      body: Column(
        children: [
          _buildCategorySelector(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: filteredDuas.length,
              itemBuilder: (context, index) {
                return _buildDouaaCard(filteredDuas[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySelector() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilterChip(
              label: Text(_categories[index]),
              selected: _selectedCategory == _categories[index],
              onSelected: (bool selected) {
                setState(() {
                  _selectedCategory = selected ? _categories[index] : 'All';
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildDouaaCard(Douaa douaa) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              douaa.title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              douaa.arabicText,
              style: const TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 12.0),
            Text(
              douaa.translation,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[700],
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              douaa.transliteration,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}