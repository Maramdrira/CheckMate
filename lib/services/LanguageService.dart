import 'package:flutter/material.dart';

class LanguageService extends ChangeNotifier {
  bool _isArabic = false;

  bool get isArabic => _isArabic;

  void toggleLanguage() {
    _isArabic = !_isArabic;
    notifyListeners();
  }

  String tr(String english, {required String arabic}) {
    return _isArabic ? arabic : english;
  }

  TextDirection get direction =>
      _isArabic ? TextDirection.ltr : TextDirection.ltr;


    
}
