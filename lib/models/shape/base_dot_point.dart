part of '../../flutter_kakao_map.dart';


class _BaseDotPoint extends _BasePoint {
  final LatLng basePoint;
  final List<_BaseDotPoint> _holes = [];

  _BaseDotPoint(this.basePoint);

  void addHole(_BaseDotPoint hole) => _holes.add(hole);

  int get holeCount => _holes.length;

  _BaseDotPoint? getHole(int index) => _holes[index];

  void removeHole(int index) => _holes.removeAt(index);

  @override
  Map<String, dynamic> toMessageable() {
    return {
      "basePoint": basePoint.toMessageable(),
      "holes": _holes.map((e) => e.toMessageable())
    };
  }

  @override
  int get type => 1;

  PointShapeType get dotType => PointShapeType.points;
}