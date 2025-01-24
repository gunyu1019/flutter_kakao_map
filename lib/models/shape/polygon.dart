part of '../../flutter_kakao_map.dart';

class Polygon<T extends _BasePoint> {
  final String id;
  
  PolygonStyle _style;
  PolygonStyle get style => _style;

  T _position;
  T get position => _position;

  Polygon._(this.id, {
    required T position,
    required PolygonStyle style
  }) : _style = style, _position = position;
}
