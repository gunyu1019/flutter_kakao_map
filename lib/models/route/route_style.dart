part of '../../flutter_kakao_map.dart';


class RouteStyle with KMessageable {
  String? _id;
  String? get id => _id;

  RoutePattern? pattern;

  final Color color;
  final double lineWidth;

  final Color strokeColor;
  final double strokeWidth;

  int zoomLevel;

  final List<RouteStyle> _styles = [];
  final bool _isSecondaryStyle;

  RouteStyle(this.color, this.lineWidth, {
    String? id,
    this.strokeColor = Colors.black, 
    this.strokeWidth = 0,
    this.pattern,
    this.zoomLevel = 0
  }) : _id = id, _isSecondaryStyle = false;

  RouteStyle._(this.color, this.lineWidth, {
    String? id,
    this.strokeColor = Colors.black, 
    this.strokeWidth = 0,
    this.pattern,
    this.zoomLevel = 0
  }) : _id = id, _isSecondaryStyle = true;

  void addStyle(int zoomLevel, Color? color, double? lineWidth, {
    Color? strokeColor,
    double? strokeWidth,
    RoutePattern? pattern,
  }) {
    if (_isSecondaryStyle) return;
    final otherStyle = RouteStyle._(
      color ?? this.color, 
      lineWidth ?? this.lineWidth,
      strokeColor: strokeColor ?? this.strokeColor,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      pattern: pattern ?? this.pattern,
      zoomLevel: zoomLevel
    );
    _styles.add(otherStyle);
  }

  RouteStyle? getStyle(int zoomLevel) {
    if (_isSecondaryStyle) return null;
    return _styles.where((e) => e.zoomLevel == zoomLevel).firstOrNull;
  }

  void removeStyle(int zoomLevel) {
    if (_isSecondaryStyle) return;
    _styles.removeWhere((e) => e.zoomLevel == zoomLevel);
  }

  @override
  Map<String, dynamic> toMessageable() {
    final payload = <String, dynamic>{
      "id": _id,
      // ignore: deprecated_member_use
      "color": color.value,
      "lineWidth": lineWidth,
      "strokeWidth": strokeWidth,
      // ignore: deprecated_member_use
      "strokeColor": strokeColor.value,
      "pattern": pattern?.toMessageable(),
      "zoomLevel": zoomLevel
    };
    if (!_isSecondaryStyle) {
      payload['otherStyle'] = _styles.map((e) => e.toMessageable()).toList();
    }
    return payload;
  }
}
