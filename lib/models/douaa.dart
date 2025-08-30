class Douaa {
  final String id;
  final String title;
  final String arabicText;
  final String translation;
  final String transliteration;
  final String category;

  Douaa({
    required this.id,
    required this.title,
    required this.arabicText,
    required this.translation,
    required this.transliteration,
    required this.category,
  });

  factory Douaa.fromJson(Map<String, dynamic> json) => Douaa(
        id: json['id'],
        title: json['title'],
        arabicText: json['arabicText'],
        translation: json['translation'],
        transliteration: json['transliteration'],
        category: json['category'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'arabicText': arabicText,
        'translation': translation,
        'transliteration': transliteration,
        'category': category,
      };
}