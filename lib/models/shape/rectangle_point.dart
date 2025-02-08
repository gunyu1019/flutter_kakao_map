part of '../../kakao_map.dart';

class RectanglePoint extends _BaseDotPoint {
  final double width;
  final double height;
  final bool clockwise;

  RectanglePoint(this.width, this.height, super.basePoint,
      {this.clockwise = false});

  @override
  Map<String, dynamic> toMessageable([bool isHole = false]) {
    final payload = <String, dynamic>{
      "type": type,
      "dotType": dotType.value,
      "width": width,
      "height": height,
      "clockwise": clockwise,
    };
    payload.addAll(super.toMessageable(isHole));
    return payload;
  }

  @override
  int get type => 1;

  @override
  PointShapeType get dotType => PointShapeType.rectangle;
}
