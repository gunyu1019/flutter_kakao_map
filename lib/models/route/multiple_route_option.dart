part of '../../flutter_kakao_maps.dart';

class MultipleRouteOption with KMessageable {
  final String? id;

  final List<CurveType> _curveType;
  final List<List<LatLng>> _points;
  final List<int> _styleIndex;
  final List<RouteStyle> _styles;

  MultipleRouteOption(
    List<RouteStyle>? styles, {
    List<LatLng>? point,
    CurveType curveType = CurveType.none,
    this.id,
  })  : _points = [],
        _styles = styles ?? [],
        _curveType = [],
        _styleIndex = [] {
    if (point != null && _styles.isNotEmpty) {
      addRouteWithIndex(point, 0, curveType);
    }
  }

  void addRouteWithStyle(List<LatLng> point, RouteStyle style,
      [CurveType curveType = CurveType.none]) {
    _styles.add(style);
    _points.add(point);
    _styleIndex.add(_styles.length);
    _curveType.add(curveType);
  }

  void addRouteWithIndex(List<LatLng> point, int styleIndex,
      [CurveType curveType = CurveType.none]) {
    _points.add(point);
    _styleIndex.add(styleIndex);
    _curveType.add(curveType);
  }

  void addRouteStyle(RouteStyle style) => _styles.add(style);

  List<LatLng>? getPoints(int index) => _points[index];

  RouteStyle? getStyle(int index) => _styles[index];

  @override
  Map<String, dynamic> toMessageable() {
    return <String, dynamic>{
      "id": id,
      "routes": _points.mapIndexed((index, points) => {
            <String, dynamic>{
              "points": points,
              "styleIndex": _styleIndex[index],
              "curveType": _curveType[index]
            }
          })
    };
  }
}
