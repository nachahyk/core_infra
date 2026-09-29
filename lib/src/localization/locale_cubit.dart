import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _prefsKey = 'locale_code';
const supportedLocales = [Locale('en'), Locale('th')];

/// Holds the app's current display language and persists the choice so it
/// survives a restart. Also mirrors the choice into `Intl.defaultLocale` so
/// locale-free `NumberFormat`/`DateFormat` calls (e.g. `Formatters.baht`)
/// automatically follow it without threading `BuildContext` through them.
class LocaleCubit extends Cubit<Locale> {
  LocaleCubit(this._prefs) : super(_readPersisted(_prefs)) {
    Intl.defaultLocale = state.languageCode;
  }

  final SharedPreferences _prefs;

  static Locale _readPersisted(SharedPreferences prefs) {
    final code = prefs.getString(_prefsKey);
    return supportedLocales.firstWhere(
      (locale) => locale.languageCode == code,
      orElse: () => const Locale('en'),
    );
  }

  Future<void> setLocale(Locale locale) async {
    if (locale == state) return;
    await _prefs.setString(_prefsKey, locale.languageCode);
    Intl.defaultLocale = locale.languageCode;
    emit(locale);
  }
}
