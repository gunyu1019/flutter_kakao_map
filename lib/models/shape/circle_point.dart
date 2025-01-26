part of '../../flutter_kakao_map.dart';


class CirclePoint extends _BaseDotPoint {
  final double radius;
  final bool clockwise;
  final int? vertexCount;

  CirclePoint(
    this.radius, super.basePoint, {
      this.clockwise = false,
      this.vertexCount
  });

  @override
  Map<String, dynamic> toMessageable([bool isHole = false]) {
    final payload = <String, dynamic>{
      "type": type,
      "dotType": dotType,
      "radius": radius,
      "clockwise": clockwise,
      "vertexCount": vertexCount,
    };
    payload.addAll(super.toMessageable());
    return payload;
  }

  @override
  int get type => 1;

  @override
  PointShapeType get dotType => PointShapeType.none;
}