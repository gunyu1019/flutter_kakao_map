part of '../../../kakao_map_sdk.dart';

enum PointShapeType {
  circle(0),
  rectangle(1),
  points(2),
  none(-1);

  final int value;

  const PointShapeType(this.value);
}
