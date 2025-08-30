class Tasbih {
  final String id;
  final String title;
  final String arabicText;
  final String translation;
  final String transliteration;
  final String category;
  final int targetCount;
  final String recommendation;

  Tasbih({
    required this.id,
    required this.title,
    required this.arabicText,
    required this.translation,
    required this.transliteration,
    required this.category,
    required this.targetCount,
    required this.recommendation,
  });

  factory Tasbih.fromJson(Map<String, dynamic> json) => Tasbih(
        id: json['id'],
        title: json['title'],
        arabicText: json['arabicText'],
        translation: json['translation'],
        transliteration: json['transliteration'],
        category: json['category'],
        targetCount: json['targetCount'],
        recommendation: json['recommendation'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'arabicText': arabicText,
        'translation': translation,
        'transliteration': transliteration,
        'category': category,
        'targetCount': targetCount,
        'recommendation': recommendation,
      };
}