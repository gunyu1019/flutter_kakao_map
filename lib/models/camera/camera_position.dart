part of '../../flutter_kakao_maps.dart';


/// 지도의 카메라 속성을 가지고 있는 객체입니다.
class CameraPosition with KMessageable {
  /// 지도를 비추고 있는 카메라의 중심 위치를 가져옵니다.
  final LatLng position;

  /// 지도의 비추고 있는 카메라의 확대/축소 값을 가져옵니다.
  final int zoomLevel;

  /// 지도를 비추고 있는 카메라의 기울기 각도를 가져옵니다.
  final double? tiltAngle = null;

  /// 지도를 비추고 있는 카메라의 회전 각도를 가져옵니다.
  final double? rotationAngle = null;

  /// 지도를 비추고 있는 카메라의 높이를 가져옵니다.
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