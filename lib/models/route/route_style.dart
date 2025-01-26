part of '../../flutter_kakao_map.dart';


class RouteStyle {
  RoutePattern? pattern;

  final Color color;
  final double lineWidth;

  final Color strokeColor;
  final double strokeWidth;

  int zoomLevel;

  RouteStyle(this.color, this.lineWidth, {
    this.strokeColor = Colors.black, 
    this.strokeWidth = 0,
    this.pattern,
    this.zoomLevel = 0
  });
}
