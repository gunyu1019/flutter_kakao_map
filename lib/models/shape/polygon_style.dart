part of '../../flutter_kakao_maps.dart';

class PolygonStyle with KMessageable {
  String? _id;
  String? get id => _id;

  Color color;
  final double strokeWidth;
  final Color strokeColor;
  int zoomLevel;

  final List<PolygonStyle> _styles = [];
  final bool _isSecondaryStyle;

  void _setStyleId(String id) {
    _id = id;
    if (!_isSecondaryStyle) {
      for (PolygonStyle e in _styles) {
        e._id = id;
      }
    }
  }

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
      "id": _id,
      // ignore: deprecated_member_use
      "color": color.value,
      "strokeWidth": strokeWidth,
      // ignore: deprecated_member_use
      "strokeColor": strokeColor.value,
      "zoomLevel": zoomLevel
    };
    if (!_isSecondaryStyle) {
      payload['otherStyle'] = _styles.map((e) => e.toMessageable()).toList();
    }
    return payload;
  }
}
