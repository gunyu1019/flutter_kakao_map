part of '../../flutter_kakao_maps.dart';

class Route {
  final RouteController _controller;
  final String id;

  List<LatLng> _points;
  List<LatLng> get points => _points;

  RouteStyle _style;
  RouteStyle get style => _style;

  CurvedType _curvedType;
  CurvedType get curvedType => _curvedType;

  Route._(this._controller, this.id,
      {required List<LatLng> points,
      required RouteStyle style,
      required CurvedType curvedType})
      : _points = points,
        _style = style,
        _curvedType = curvedType;
}
