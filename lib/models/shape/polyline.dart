part of '../../flutter_kakao_map.dart';

class Polyline<T extends _BasePoint> {
  final String id;
  
  PolylineStyle _style;
  PolylineStyle get style => _style;

  T _position;
  T get position => _position;

  Polyline._(this.id, {
    required T position,
    required PolylineStyle style
  }) : _style = style, _position = position;
}
