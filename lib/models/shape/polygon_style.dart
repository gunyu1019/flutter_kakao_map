// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../../flutter_kakao_map.dart';

class PolygonStyle with KMessageable {
  String? _id;
  String? get id => _id;

  Color color;
  final double strokeWidth;
  final Color strokeColor;
  int zoomLevel;

  final List<PolygonStyle> _styles = [];
  final bool _isSecondaryStyle;

  PolygonStyle(this.color, {
    String? id,
    this.strokeWidth = .0,
    this.strokeColor = Colors.black,
    this.zoomLevel = 0,
  }) : _id = id, _isSecondaryStyle = false;

  PolygonStyle._(this.color, {
    String? id,
    this.strokeWidth = .0,
    this.strokeColor = Colors.black,
    this.zoomLevel = 0,
  }) : _id = id, _isSecondaryStyle = true;

  void addStyle(int zoomLevel, Color? color, {
    double? strokeWidth,
    Color? strokeColor
  }) {
    if (_isSecondaryStyle) return;
    final otherStyle = PolygonStyle._(
      color ?? this.color, 
      strokeColor: strokeColor ?? this.strokeColor,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      zoomLevel: zoomLevel
    );
    _styles.add(otherStyle);
  }

  PolygonStyle? getStyle(int zoomLevel) {
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
    };
    if (!_isSecondaryStyle) {
      payload['otherStyle'] = _styles.map((e) => e.toMessageable()).toList();
    }
    return payload;
  }
}
