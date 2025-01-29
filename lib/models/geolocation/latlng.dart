part of '../../flutter_kakao_maps.dart';

/// 위도(Latitude)와 경도(longitude)를 사용하여 좌표를 나타내는 객체입니다.
class LatLng with KMessageable {
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

  @override
  Map<String, dynamic> toMessageable() {
    return {
      "latitude": latitude,
      "longitude": longitude
    };
  }
}