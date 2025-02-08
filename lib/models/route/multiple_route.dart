part of '../../kakao_map.dart';


class MultipleRoute {
  final RouteController _controller;
  final String id;

  final List<CurveType> _curveType;
  final List<List<LatLng>> _points;
  final List<int> _styleIndex;
  List<RouteStyle> _styles;

  bool _visible;
  bool get visible => _visible;

  MultipleRoute._(this._controller, this.id,
      {required List<List<LatLng>> points,
      required List<RouteStyle> style,
      required List<CurveType> curveType,
      required List<int> styleIndex})
      : _points = points,
        _styles = style,
        _curveType = curveType,
        _styleIndex = styleIndex,
        _visible = true;

  Route getRoute(int index) => Route._fromMultiple(
    _controller, id, this, 
    points: _points[index],
    style: _styles[_styleIndex[index]], 
    curveType: _curveType[index]
  );

  Future<void> show() async {
    await _controller._changeRouteVisible(id, true);
    _visible = true;
  }

  Future<void> hide() async {
    await _controller._changeRouteVisible(id, false);
    _visible = false;
  }

  RouteStyle getStyle(int index) => _styles[_styleIndex[index]];

  List<LatLng> getPoints(int index) => _points[index];

  CurveType getCurveType(int index) => _curveType[index];

  Future<void> remove() async {
    await _controller.removeMultipleRoute(this);
  }

  Future<void> changePoint(int index, List<LatLng> points) async {
    _points[index] = points;
    await _controller._changePoints(id, _points);
  }

  Future<void> changeCurveType(int index, CurveType curveType) async {
    _curveType[index] = curveType;
    await _controller._changeCurveType(id, _curveType);
  }

  Future<void> changeStyle(List<RouteStyle> styles) async {
    if (styles.isEmpty) {
      throw Exception("styles parameter is empty.");
    }
    final styleId = styles[0].id ?? await _controller.manager.addMultipleRouteStyle(styles);
    await _controller._changeStyle(id, styleId);
    _styles = styles;
  }
}