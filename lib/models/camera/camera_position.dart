part of '../../flutter_kakao_map.dart';


class CameraPosition {
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

  Map<String, dynamic> toMessageable() {
    return {
      "latitiude": position.latitude,
      "longitude": position.longitude,
      "zoomLevel": zoomLevel,
      "tiltAngle": tiltAngle ?? -1.0,
      "rotationAngle": rotationAngle ?? -1.0,
      "height": height ?? -1.0,
    };
  }

  @override
  String toString() => "$runtimeType: ${toMessageable().map}";
}