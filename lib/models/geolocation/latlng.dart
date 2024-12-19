part of '../../flutter_kakao_map.dart';


class LatLng {
  final double latitude;
  final double longitude;

  const LatLng(
    this.latitude,
    this.longitude
  );

  factory LatLng.fromMessageable(dynamic payload) 
    => LatLng(
      payload['latitude'],
      payload['longitude']
    );

  Map<String, dynamic> toMessageable() {
    return {
      "latitude": latitude,
      "longitude": longitude
    };
  }

  @override
  String toString() => "$runtimeType: ${toMessageable().map}";
}