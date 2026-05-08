import 'package:flutter/material.dart';

class LocalizationService extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  Future<void> changeLocale(String languageCode) async {
    _locale = Locale(languageCode);

    notifyListeners();
  }
}
