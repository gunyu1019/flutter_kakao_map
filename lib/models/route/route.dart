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

  final bool _isMultiple;
  final MultipleRoute? parents;

  bool _visible;
  bool get visible => _visible;

  Route._(this._controller, this.id,
      {required List<LatLng> points,
      required RouteStyle style,
      required CurveType curveType})
      : _points = points,
        _style = style,
        _curveType = curveType,
        _isMultiple = false,
        _visible = true,
        parents = null;

  Route._fromMultiple(this._controller, this.id, this.parents,
      {required List<LatLng> points,
      required RouteStyle style,
      required CurveType curveType})
      : _points = points,
        _style = style,
        _curveType = curveType,
        _visible = true,
        _isMultiple = true;

  Future<void> show() async {
    _visible = true;
  }

  Future<void> hide() async {
    _visible = false;
  }

  Future<void> remove() async {
    await _controller.removeRoute(this);
  }

  Future<void> changeStyle(RouteStyle style) async {
    String styleId = style.id ?? await _controller.manager.addRouteStyle(style);
    await _controller._changeStyle(id, styleId);
    _style = style;
  }

  Future<void> changeCurveType(CurveType curveType) async {
    await _controller._changeCurveType(id, [curveType]);
    _curveType = curveType;
  }

  Future<void> changePoint(List<LatLng> points) async {
    await _controller._changePoints(id, [points]);
    _points = points;
  }
}
