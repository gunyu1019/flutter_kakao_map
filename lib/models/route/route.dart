part of '../../flutter_kakao_maps.dart';

class Route {
  final RouteController _controller;
  final String id;

  List<LatLng> _points;
  List<LatLng> get points => _points;

  RouteStyle _style;
  RouteStyle get style => _style;

  CurveType _curveType;
  CurveType get curveType => _curveType;

  Route._(this._controller, this.id,
      {required List<LatLng> points,
      required RouteStyle style,
      required CurveType curveType})
      : _points = points,
        _style = style,
        _curveType = curveType;
}
