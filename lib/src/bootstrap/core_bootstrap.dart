import 'package:supabase_flutter/supabase_flutter.dart';

import '../config/supabase_config.dart';

/// Initializes the one piece of infrastructure every mini-app needs before
/// anything else runs. Call once, from the shell's `main()`, before
/// constructing any module.
Future<void> initializeCore() async {
  await Supabase.initialize(
    url: SupabaseConfig.url,
    publishableKey: SupabaseConfig.publishableKey,
  );
}
