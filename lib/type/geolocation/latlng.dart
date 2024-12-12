part of '../../flutter_kakao_map.dart';


class LatLng {
  final double latitude;
  final double longitude;

  const LatLng(
    this.latitude,
    this.longitude
  );

  Map<String, dynamic> toMessageable() {
    return {
      "latitiude": latitude,
      "longitude": longitude
    };
  }
}