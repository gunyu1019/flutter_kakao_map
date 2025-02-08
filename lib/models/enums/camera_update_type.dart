part of '../../kakao_map.dart';

enum CameraUpdateType {
  newCenterPoint(value: 0),
  newCameraPos(value: 1),
  newCameraAngle(value: 2),
  zoomTo(value: 3),
  zoomIn(value: 4),
  zoomOut(value: 5),
  rotate(value: 6),
  tilt(value: 7),
  fitMapPoints(value: 8);

  final int value;

  const CameraUpdateType({required this.value});
}
