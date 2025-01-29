part of '../../flutter_kakao_maps.dart';


/// 지도의 카메라 속성을 가지고 있는 객체입니다.
class CameraPosition with KMessageable {
  final LatLng position;
  final int zoomLevel;
  final double? tiltAngle = null;
  final double? rotationAngle = null;
  final double? height = null;

  const CameraPosition(
    this.position,
    this.zoomLevel, {
      tiltAngle,
      rotationAngle,
      height
  });

  factory CameraPosition.fromMessageable(dynamic payload) 
    => CameraPosition(
      LatLng.fromMessageable(payload),
      payload['zoomLevel'],
      tiltAngle: payload['tiltAngle'],
      rotationAngle: payload['rotationAngle'],
      height: payload['height'],
    );

  @override
  Map<String, dynamic> toMessageable() {
    return {
      "latitude": position.latitude,
      "longitude": position.longitude,
      "zoomLevel": zoomLevel,
      "tiltAngle": tiltAngle ?? -1.0,
      "rotationAngle": rotationAngle ?? -1.0,
      "height": height ?? -1.0,
    };
  }
}