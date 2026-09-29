import 'package:dio/dio.dart';

import 'package:core_infra/src/location/picked_location.dart';

/// Thin wrapper around OpenStreetMap's free Nominatim geocoding API.
///
/// Nominatim's usage policy caps public API use at ~1 request/second and
/// asks callers to identify themselves via `User-Agent` — search is
/// deliberately search-on-submit (not live-as-you-type) to stay well within
/// that limit.
class NominatimGeocodingDataSource {
  NominatimGeocodingDataSource({String userAgent = 'JungStudioApp/1.0'})
      : _dio = Dio(BaseOptions(
          baseUrl: 'https://nominatim.openstreetmap.org',
          headers: {'User-Agent': userAgent},
        ));

  final Dio _dio;

  Future<String?> reverseGeocode(double lat, double lng) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/reverse',
      queryParameters: {'format': 'jsonv2', 'lat': lat, 'lon': lng},
    );
    return response.data?['display_name'] as String?;
  }

  Future<List<PickedLocation>> search(String query) async {
    final response = await _dio.get<List<dynamic>>(
      '/search',
      queryParameters: {'format': 'jsonv2', 'q': query, 'limit': 5},
    );
    final results = response.data ?? const [];
    return results.map((row) {
      final map = row as Map<String, dynamic>;
      return PickedLocation(
        address: map['display_name'] as String,
        latitude: double.parse(map['lat'] as String),
        longitude: double.parse(map['lon'] as String),
      );
    }).toList();
  }
}
