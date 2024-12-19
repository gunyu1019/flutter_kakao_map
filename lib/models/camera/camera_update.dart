part of '../../flutter_kakao_map.dart';


class CameraUpdate {
  final CameraUpdateType type;
  final LatLng? position;
  final int zoomLevel;

  // CameraUpdateType.newCameraPos
  final CameraPosition? cameraPosition;

  // For CameraUpdateType.rotate, CameraUpdateType.tilt
  final double angle;

  // For CameraUpdateType.fitMapPoints
  final List<LatLng>? fitPoints;
  final int? padding;

  CameraUpdate._(this.type, {
    this.position,
    this.zoomLevel = -1,
    this.cameraPosition,
    this.angle = -1.0,
    this.fitPoints,
    this.padding,
  });

  factory CameraUpdate.newCenterPosition(LatLng position, {int? zoomLevel})
    => CameraUpdate._(CameraUpdateType.newCenterPoint, position: position, zoomLevel: zoomLevel ?? -1);

  factory CameraUpdate.newCameraPos(CameraPosition cameraPosition)
    => CameraUpdate._(CameraUpdateType.newCameraPos, cameraPosition: cameraPosition);

  factory CameraUpdate.zoomTo(int zoomLevel)
    => CameraUpdate._(CameraUpdateType.zoomTo, zoomLevel: zoomLevel);

  factory CameraUpdate.zoomIn()
    => CameraUpdate._(CameraUpdateType.zoomIn);

  factory CameraUpdate.zoomOut()
    => CameraUpdate._(CameraUpdateType.zoomOut);

  factory CameraUpdate.rotate(double angle)
    => CameraUpdate._(CameraUpdateType.rotate, angle: angle);

  factory CameraUpdate.tilt(double angle)
    => CameraUpdate._(CameraUpdateType.tilt, angle: angle);

  factory CameraUpdate.fitMapPoints(List<LatLng> fitPoints, int? padding, int? zoomLevel)
    => CameraUpdate._(CameraUpdateType.tilt, fitPoints: fitPoints, padding: padding, zoomLevel: zoomLevel ?? -1);

  Map<String, dynamic> toMessageable() {
    Map<String, dynamic> payload = {
      "type": type.value
    };
    switch(type) {
      case CameraUpdateType.newCenterPoint:
        payload['position'] = position!.toMessageable();
      case CameraUpdateType.zoomTo:
        payload['zoomLevel'] = zoomLevel;
        break;
      case CameraUpdateType.newCameraPos:
        payload.addAll(cameraPosition!.toMessageable());
        break;
      case CameraUpdateType.newCameraAngle: // Nothing payload.
      case CameraUpdateType.zoomIn:
      case CameraUpdateType.zoomOut:
        break;
      case CameraUpdateType.rotate:
      case CameraUpdateType.tilt:
        payload['angle'] = angle;
        break;
      case CameraUpdateType.fitMapPoints:
        payload['points'] = fitPoints!.map((latlng) { latlng.toMessageable(); });
        payload['padding'] = padding ?? 0;
        payload['zoomLevel'] = zoomLevel;
        break;
    }
    return payload;
  }

  @override
  String toString() => "$runtimeType: ${toMessageable().map}";
}