import 'package:shared_preferences/shared_preferences.dart';

/// Remembers which first-run guided tours this device has already seen (or
/// skipped), so each shows exactly once. One instance is shared app-wide;
/// each tour is identified by a short id (e.g. `'landing'`, `'aim_jung'`).
class FirstRunTours {
  FirstRunTours(this._prefs);

  final SharedPreferences _prefs;

  // `<id>_tutorial_seen` — kept compatible with the landing tour's original
  // `landing_tutorial_seen` key, so devices that saw it don't see it again.
  static String _key(String tourId) => '${tourId}_tutorial_seen';

  bool shouldShow(String tourId) => !(_prefs.getBool(_key(tourId)) ?? false);

  Future<void> markSeen(String tourId) => _prefs.setBool(_key(tourId), true);
}
