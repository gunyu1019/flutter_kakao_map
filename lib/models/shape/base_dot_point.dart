part of '../../kakao_map.dart';

sealed class _BaseDotPoint extends BasePoint {
  final LatLng? basePoint;
  final List<_BaseDotPoint> _holes = [];

  _BaseDotPoint(this.basePoint);

  void addHole(_BaseDotPoint hole) => _holes.add(hole);

  int get holeCount => _holes.length;

  _BaseDotPoint? getHole(int index) => _holes[index];

  void removeHole(int index) => _holes.removeAt(index);

  @override
  Map<String, dynamic> toMessageable([bool isHole = false]) {
    final payload = <String, dynamic>{};
    if (!isHole) {
      payload["basePoint"] = basePoint!.toMessageable();
      payload["holes"] = _holes.map((e) => e.toMessageable(true)).toList();
    }
    return payload;
  }

  @override
  int get type => 1;

  PointShapeType get dotType => PointShapeType.points;
}
