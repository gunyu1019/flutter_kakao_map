part of '../../flutter_kakao_map.dart';

class PolylineStyle with KMessageable {
  String? _id;
  String? get id => _id;

  Color color;
  double lineWidth;
  final double strokeWidth;
  final Color strokeColor;
  int zoomLevel;

  final List<PolylineStyle> _styles = [];
  final bool _isSecondaryStyle;

  void _setStyleId(String id) {
    _id = id;
    if (!_isSecondaryStyle) {
      for (PolylineStyle e in _styles) {
        e._id = id;
      }
    }
  }

  PolylineStyle(this.color, this.lineWidth, {
    String? id,
    this.strokeWidth = .0,
    this.strokeColor = Colors.black,
    this.zoomLevel = 0,
  }) : _id = id, _isSecondaryStyle = false;

  PolylineStyle._(this.color, this.lineWidth, {
    String? id,
    this.strokeWidth = .0,
    this.strokeColor = Colors.black,
    this.zoomLevel = 0,
  }) : _id = id, _isSecondaryStyle = true;

  void addStyle(int zoomLevel, {
    Color? color,
    double? lineWidth,
    double? strokeWidth,
    Color? strokeColor
  }) {
    if (_isSecondaryStyle) return;
    final otherStyle = PolylineStyle._(
      color ?? this.color, 
      lineWidth ?? this.lineWidth,
      strokeColor: strokeColor ?? this.strokeColor,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      zoomLevel: zoomLevel
    );
    _styles.add(otherStyle);
  }

  PolylineStyle? getStyle(int zoomLevel) {
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
      // ignore: deprecated_member_use
      "color": color.value,
      "lineWidth": lineWidth,
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
