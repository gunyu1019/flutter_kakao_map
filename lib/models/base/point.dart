part of '../../flutter_kakao_map.dart';

class KPoint {
  final double x;
  final double y;

  const KPoint(this.x, this.y);

  Map<String, dynamic> toMessageable() {
    final payload = <String, dynamic>{
      "x": x,
      "y": y,
    };
    return payload;
  }
}
