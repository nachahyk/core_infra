import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _prefsKey = 'theme_mode';

/// Holds the app's light/dark/system appearance choice and persists it so it
/// survives a restart — the theme counterpart of [LocaleCubit]. Every
/// mini-app's own light/dark theme (via `MiniAppThemeSwitcher`) follows it.
class ThemeModeCubit extends Cubit<ThemeMode> {
  ThemeModeCubit(this._prefs) : super(_readPersisted(_prefs));

  final SharedPreferences _prefs;

  static ThemeMode _readPersisted(SharedPreferences prefs) {
    final name = prefs.getString(_prefsKey);
    return ThemeMode.values.firstWhere((mode) => mode.name == name, orElse: () => ThemeMode.system);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (mode == state) return;
    await _prefs.setString(_prefsKey, mode.name);
    emit(mode);
  }
}
