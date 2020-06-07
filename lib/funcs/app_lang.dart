import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String LAGUAGE_CODE = 'languageCode';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LAGUAGE_CODE, languageCode);
  switch (languageCode) {
    case 'en':
      return Locale('en', 'US');
    case 'ru':
      return Locale('ru', 'RU');
    default:
      return Locale('en', 'US');
  }
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LAGUAGE_CODE) ?? "en";
  switch (languageCode) {
    case 'en':
      return Locale('en', 'US');
    case 'ru':
      return Locale('ru', 'RU');
    default:
      return Locale('en', 'US');
  }
}
