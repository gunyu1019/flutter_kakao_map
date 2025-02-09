part of '../../kakao_map_sdk.dart';

enum GestureType {
  oneFingerDoubleTap(value: 1),
  twoFingerSingleTap(value: 2),
  pan(value: 5),
  rotate(value: 6),
  zoom(value: 7),
  tilt(value: 8),
  longTapAndDrag(value: 9),
  rotateZoom(value: 10),
  oneFingerZoom(value: 11),
  unknown(value: 17);

  final int value;

  const GestureType({required this.value});
}
