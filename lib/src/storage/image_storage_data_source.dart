import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

/// Uploads images to a Supabase Storage bucket and returns their public URL.
///
/// Each bucket must be created manually (public read + a staff/admin-only
/// insert policy) — this data source assumes it already exists.
class ImageStorageDataSource {
  ImageStorageDataSource(this._client, {required this.bucket});

  final SupabaseClient _client;
  final String bucket;

  Future<String> uploadImage({
    required String fileName,
    required Uint8List bytes,
    String? contentType,
  }) async {
    final path = '${DateTime.now().millisecondsSinceEpoch}_$fileName';
    await _client.storage
        .from(bucket)
        .uploadBinary(path, bytes, fileOptions: FileOptions(contentType: contentType));
    return _client.storage.from(bucket).getPublicUrl(path);
  }
}
