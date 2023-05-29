import 'dart:ui';

import 'package:msquare_market/v2/core/constants/static_values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageServices {
  Locale? locale;

  SharedPreferences? prefs;
  var language;

  LanguageServices() {
    initLanguages();
  }

  initLanguages() async {
    prefs = await SharedPreferences.getInstance();

    language = prefs!.getString('lang');
    locale = localeMapping[language ?? "English"];
  }
}
