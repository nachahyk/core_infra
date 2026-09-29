import 'package:url_launcher/url_launcher.dart';

/// Opens OpenStreetMap (in the browser, or a maps app that handles the URL)
/// centered on the given coordinates.
Future<void> openLocationInMap(double latitude, double longitude) {
  final uri = Uri.parse('https://www.openstreetmap.org/?mlat=$latitude&mlon=$longitude#map=17/$latitude/$longitude');
  return launchUrl(uri, mode: LaunchMode.externalApplication);
}
