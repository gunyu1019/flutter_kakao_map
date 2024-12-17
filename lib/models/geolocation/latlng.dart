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
      payload['latitiude'],
      payload['longitude']
    );

  Map<String, dynamic> toMessageable() {
    return {
      "latitiude": latitude,
      "longitude": longitude
    };
  }

  @override
  String toString() => "$runtimeType: ${toMessageable().map}";
}