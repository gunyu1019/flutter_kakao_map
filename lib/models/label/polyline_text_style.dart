part of '../../flutter_kakao_map.dart';

class PolylineTextStyle {
  bool applyDpScale;
  int zoomLevel;

  final int size;
  final int? strokeSize;
  final Color color;
  final Color? strokeColor;

  final List<PolylineTextStyle> _styles = [];
  final bool _isSecondaryStyle;

  PolylineTextStyle(this.size, this.color, {
    this.strokeSize,
    this.strokeColor,
    this.applyDpScale = true,
    this.zoomLevel = 0
  }) : _isSecondaryStyle = false;

  PolylineTextStyle._(this.size, this.color, {
    this.strokeSize,
    this.strokeColor,
    this.applyDpScale = true,
    this.zoomLevel = 0
  }) : _isSecondaryStyle = true;

  void addStyle(int zoomLevel, {
    int? size,
    Color? color,
    bool? applyDpScale,
    int? strokeSize,
    Color? strokeColor
  }) {
    if (_isSecondaryStyle) return;

    final otherStyle = PolylineTextStyle._(
      size ?? this.size,
      color ?? this.color,
      applyDpScale: applyDpScale ?? this.applyDpScale,
      strokeSize: strokeSize ?? this.strokeSize,
      strokeColor: strokeColor ?? this.strokeColor,
      zoomLevel: zoomLevel
    );
    _styles.add(otherStyle);
  }

  PolylineTextStyle? getStyle(int zoomLevel) {
    return _styles.where((e) => e.zoomLevel == zoomLevel).firstOrNull;
  }

  void removeStyle(int zoomLevel) {
    _styles.removeWhere((e) => e.zoomLevel == zoomLevel);
  }

  Map<String, dynamic> toMessageable() {
    final payload = <String, dynamic>{
      "applyDpScale": applyDpScale,
      // ignore: deprecated_member_use
      "color": color.value,
      "size": size,
      "strokeSize": strokeSize,
      // ignore: deprecated_member_use
      "strokeColor": strokeColor?.value,
    };
    if (!_isSecondaryStyle) {
      payload['otherStyle'] = _styles.map((e) => e.toMessageable()).toList();
    }
    return payload;
  }
}