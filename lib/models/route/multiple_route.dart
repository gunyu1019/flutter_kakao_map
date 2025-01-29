part of '../../flutter_kakao_maps.dart';


class MultipleRoute {
  final RouteController _controller;
  final String id;

  final List<CurveType> _curveType;
  final List<List<LatLng>> _points;
  final List<int> _styleIndex;
  final List<RouteStyle> _styles;

  MultipleRoute._(this._controller, this.id,
      {required List<List<LatLng>> points,
      required List<RouteStyle> style,
      required List<CurveType> curveType,
      required List<int> styleIndex})
      : _points = points,
        _styles = style,
        _curveType = curveType,
        _styleIndex = styleIndex;

  Route getRoute(int index) => Route._fromMultiple(
    _controller, id, this, 
    points: _points[index],
    style: _styles[_styleIndex[index]], 
    curveType: _curveType[index]
  );
}