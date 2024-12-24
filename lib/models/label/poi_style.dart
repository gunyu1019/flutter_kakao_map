part of '../../flutter_kakao_map.dart';

class PoiStyle {
  bool applyDpScale;
  KPoint anchor;
  double padding;
  PoiTransition iconTransition;
  int textGravity;
  KImage? icon;
  List<PoiTextStyle> textStyle;
  PoiTransition textTransition;
  int zoomLevel;

  PoiStyle({
    this.applyDpScale = true,
    this.anchor = const KPoint(0.5, 1.0),
    this.padding = 0,
    this.icon,
    this.iconTransition = const PoiTransition(),
    this.textGravity = 8,
    this.textStyle = const [],
    this.textTransition = const PoiTransition(),
    this.zoomLevel = 0
  });
  
  Map<String, dynamic> toMessageable() {
    final payload = <String, dynamic>{
      "applyDpScale": applyDpScale,
      "anchor": anchor.toMessageable(),
      "padding": padding,
      "icon": icon.toMessageable(),
      "iconTransition": iconTransition.toMessageable(),
      "textGravity": textGravity,
      "textStyle": textStyle.map((e) => e.toMessageable()),
      "zoomLevel": zoomLevel
    };
    return payload;
  }
}
