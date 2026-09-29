import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Read-only Google Maps preview of a picked point, shown alongside the
/// existing free OpenStreetMap picker rather than replacing it — tap-to-pick,
/// search, and "use my location" all stay on the free flutter_map picker
/// (`LocationPickerPage`/`TjLocationPickerPage`), since that interactivity
/// would need the paid Google Maps JavaScript API plus a JS↔Dart bridge.
/// This widget just confirms "here's your point on Google Maps," via the
/// free (unofficial, key-less) embed URL — which is why it's WebView-only
/// and not draggable/tappable itself.
class GoogleMapPreview extends StatefulWidget {
  const GoogleMapPreview({
    super.key,
    required this.latitude,
    required this.longitude,
    this.height = 160,
    this.borderRadius = const BorderRadius.all(Radius.circular(14)),
  });

  final double latitude;
  final double longitude;
  final double height;
  final BorderRadius borderRadius;

  @override
  State<GoogleMapPreview> createState() => _GoogleMapPreviewState();
}

class _GoogleMapPreviewState extends State<GoogleMapPreview> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(_embedUri(widget.latitude, widget.longitude));
  }

  @override
  void didUpdateWidget(covariant GoogleMapPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.latitude != widget.latitude || oldWidget.longitude != widget.longitude) {
      _controller.loadRequest(_embedUri(widget.latitude, widget.longitude));
    }
  }

  static Uri _embedUri(double latitude, double longitude) =>
      Uri.parse('https://maps.google.com/maps?q=$latitude,$longitude&z=15&output=embed');

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.borderRadius,
      child: SizedBox(
        height: widget.height,
        width: double.infinity,
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}
