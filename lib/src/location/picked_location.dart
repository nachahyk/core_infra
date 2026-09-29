/// A location the user chose via a map picker — a resolved address string
/// alongside its coordinates. Shared across mini-apps that let a user pin a
/// place (AimJung's delivery address, Tiaw Jung's itinerary stops).
class PickedLocation {
  const PickedLocation({required this.address, required this.latitude, required this.longitude});

  final String address;
  final double latitude;
  final double longitude;
}
