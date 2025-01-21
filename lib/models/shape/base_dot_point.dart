part of '../../flutter_kakao_map.dart';


class _BaseDotPoint extends _BasePoint {
  final LatLng basePoint;

  _BaseDotPoint(this.basePoint);

  @override
  Map<String, dynamic> toMessageable() {
    return {
      "basePoint": basePoint.toMessageable()
    };
  }

  @override
  int get type => 1;
}