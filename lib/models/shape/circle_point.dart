part of '../../flutter_kakao_map.dart';


class CirclePoint extends _BaseDotPoint {
  final double radius;
  final bool clockwise;
  final int? vertexCount;

  CirclePoint(
    super.basePoint,
    this.radius, {
      this.clockwise = false,
      this.vertexCount
  });

  @override
  Map<String, dynamic> toMessageable() {
    final payload = <String, dynamic>{
      "type": type,
      "radius": radius,
      "clockwise": clockwise,
      "vertexCount": vertexCount,
    };
    payload.addAll(super.toMessageable());
    return payload;
  }

  @override
  int get type => 1;
}