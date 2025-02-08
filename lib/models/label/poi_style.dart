part of '../../flutter_kakaomaps.dart';

class PoiStyle with KMessageable {
  String? _id;
  String? get id => _id;

  bool applyDpScale;
  KPoint anchor;
  double padding;
  PoiTransition iconTransition;
  int textGravity;
  KImage? icon;
  List<PoiTextStyle> textStyle;
  PoiTransition textTransition;
  int zoomLevel;

  final List<PoiStyle> _styles = [];
  final bool _isSecondaryStyle;

  PoiStyle({
    String? id,
    this.applyDpScale = true,
    this.anchor = const KPoint(0.5, 1.0),
    this.padding = 0.0,
    this.icon,
    this.iconTransition = const PoiTransition(),
    this.textGravity = 8,
    this.textStyle = const [],
    this.textTransition = const PoiTransition(),
    this.zoomLevel = 0
  }) : _isSecondaryStyle = false, _id = id;

  PoiStyle._({
    String? id,
    this.applyDpScale = true,
    this.anchor = const KPoint(0.5, 1.0),
    this.padding = 0.0,
    this.icon,
    this.iconTransition = const PoiTransition(),
    this.textGravity = 8,
    this.textStyle = const [],
    this.textTransition = const PoiTransition(),
    this.zoomLevel = 0
  }) : _isSecondaryStyle = true, _id = id;

  void _setStyleId(String id) {
    _id = id;
    if (!_isSecondaryStyle) {
      for (PoiStyle e in _styles) {
        e._id = id;
      }
    }
  }

  void addStyle({
    required int zoomLevel,
    bool? applyDpScale,
    KPoint? anchor,
    double? padding,
    KImage? icon,
    PoiTransition? iconTransition,
    int? textGravity,
    List<PoiTextStyle>? textStyle,
    PoiTransition? textTransition,
  }) {
    if (_isSecondaryStyle) return;
    final otherStyle = PoiStyle._(
      id: id,
      applyDpScale: applyDpScale ?? this.applyDpScale,
      anchor: anchor ?? this.anchor,
      padding: padding ?? this.padding,
      icon: icon ?? this.icon,
      iconTransition: iconTransition ?? this.iconTransition,
      textGravity: textGravity ?? this.textGravity,
      textStyle: textStyle ?? this.textStyle,
      textTransition: textTransition ?? this.textTransition,
      zoomLevel: zoomLevel
    );
    _styles.add(otherStyle);
  }

  PoiStyle? getStyle(int zoomLevel) {
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
      "applyDpScale": applyDpScale,
      "anchor": anchor.toMessageable(),
      "padding": padding,
      "icon": icon?.toMessageable(),
      "iconTransition": iconTransition.toMessageable(),
      "textGravity": textGravity,
      "textStyle": textStyle.map((e) => e.toMessageable()).toList(),
      "zoomLevel": zoomLevel
    };
    if (!_isSecondaryStyle) {
      payload['otherStyle'] = _styles.map((e) => e.toMessageable()).toList();
    }
    return payload;
  }
}
