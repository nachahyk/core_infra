import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// The contract every installable mini-app implements so the shell's
/// `ModuleRegistry` can discover, list, and mount it — without the shell
/// needing to know anything about a mini-app's own domain.
abstract class AppModule {
  /// A stable, unique identifier (e.g. `'aim_jung'`) — used for route
  /// path-prefixing and persisting the user's last-selected module.
  String get id;

  /// Shown in the shell's module switcher.
  String get displayName;

  /// Shown alongside [displayName] in the module switcher.
  IconData get icon;

  /// This module's own route subtree (typically rooted at `/$id`), composed
  /// into the shell's top-level [GoRouter] alongside every other installed
  /// module's routes.
  List<RouteBase> get routes;

  /// The path the shell's switcher navigates to when this module is
  /// selected — its own root route within [routes].
  String get entryPath;

  /// Called once, when this module is selected — build this module's own
  /// repositories/Cubits here rather than eagerly at app startup, so an
  /// uninstalled or not-yet-selected module never does any work.
  Future<void> initialize();

  /// Called when switching away from this module, to release whatever
  /// [initialize] built.
  Future<void> dispose();
}
