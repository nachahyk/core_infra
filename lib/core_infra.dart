/// Pure infrastructure shared across every Jung Studio mini-app.
///
/// No domain logic lives here — Supabase bootstrap, environment config,
/// shared error/result types, and the `AppModule` contract every mini-app
/// implements so the shell's `ModuleRegistry` can discover it.
library;

export 'src/bootstrap/core_bootstrap.dart';
export 'src/config/supabase_config.dart';
export 'src/errors/failure.dart';
export 'src/localization/locale_cubit.dart';
export 'src/location/google_map_preview.dart';
export 'src/location/map_launcher.dart';
export 'src/location/nominatim_geocoding_data_source.dart';
export 'src/location/picked_location.dart';
export 'src/modules/app_module.dart';
export 'src/onboarding/first_run_tours.dart';
export 'src/storage/image_storage_data_source.dart';
export 'src/theme/theme_mode_cubit.dart';
