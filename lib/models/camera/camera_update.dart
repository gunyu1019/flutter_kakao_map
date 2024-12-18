part of '../../flutter_kakao_map.dart';


class CameraUpdate {
  final CameraUpdateType type;
  final LatLng? position = null;
  final int zoomLevel = -1;

  // CameraUpdateType.newCameraPos
  final CameraPosition? cameraPosition = null;

  // For CameraUpdateType.rotate, CameraUpdateType.tilt
  final double angle = -1.0;

  // For CameraUpdateType.fitMapPoints
  final List<LatLng>? fitPoints = null;
  final int? padding = null;

  const CameraUpdate(this.type);

  Map<String, dynamic> toMessageable() {
    Map<String, dynamic> payload = {
      "type": type.value
    }
    switch(type) {
      case CameraUpdateType.newCameraPos:
        payload['position'] = cameraPosition!.toMessageable();
      case CameraUpdateType.zoomTo:
        payload['zoomLevel'] = zoomLevel;
        break;
      case CameraUpdateType.newCenterPoint:
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
        payload['padding'] = padding;
        payload['zoomLevel'] = zoomLevel;
        break;
    }
    return payload;
  }

  @override
  String toString() => "$runtimeType: ${toMessageable().map}";
}