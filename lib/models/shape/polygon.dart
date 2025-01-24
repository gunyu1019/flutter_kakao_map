part of '../../flutter_kakao_map.dart';

class Polygon<T extends _BasePoint> {
  final ShapeController _controller;
  final String id;
  
  PolygonStyle _style;
  PolygonStyle get style => _style;

  T _position;
  T get position => _position;

  Polygon._(ShapeController controller, this.id, {
    required T position,
    required PolygonStyle style
  }) : _controller = controller, _style = style, _position = position;
}
