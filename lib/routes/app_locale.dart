// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:smartfarm/controller/textcontroller.dart';

// class AppLocale {
//   AppLocale(this.locale);

//   final Locale locale;

//   static AppLocale of(BuildContext context) {
//     return Localizations.of<AppLocale>(context, AppLocale);
//   }

//   Map<String, String> _sentences;

//   Future<bool> load() async {
//     if (TextController().uid == null) {
//       TextController().initPage.text = "/login";
//     } else if (TextController().uid != null) {
//       TextController().initPage.text = "/home";
//     }
//     String data = await rootBundle
//         .loadString('assets/language/${this.locale.languageCode}.json');
//     Map<String, dynamic> _result = json.decode(data);

//     this._sentences = new Map();
//     _result.forEach((String key, dynamic value) {
//       this._sentences[key] = value.toString();
//     });

//     return true;
//   }

//   String trans(String key) {
//     return this._sentences[key];
//   }
// }

// class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocale> {
//   const AppLocalizationsDelegate();

//   @override
//   bool isSupported(Locale locale) => ['en', 'th'].contains(locale.languageCode);

//   @override
//   Future<AppLocale> load(Locale locale) async {
//     AppLocale localizations = new AppLocale(locale);
//     await localizations.load();

//     print("Load ${locale.languageCode}");

//     return localizations;
//   }

//   @override
//   bool shouldReload(AppLocalizationsDelegate old) => false;
// }
