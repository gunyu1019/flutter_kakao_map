part of '../../flutter_kakao_map.dart';

class PoiStyle {
  String? id;
  bool applyDpScale;
  KPoint anchor;
  double padding;
  PoiTransition iconTransition;
  int textGravity;
  KImage? icon;
  List<PoiTextStyle> textStyle;
  PoiTransition textTransition;
  int zoomLevel;

  List<PoiStyle> _styles = [];

  PoiStyle({
    this.id,
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

  void addStyle({
    required int zoomLevel,
    bool? applyDpScale,
    KPoint? anchor,
    int? padding,
    KImage? icon,
    PoiTransition? iconTransition,
    int? textGravity,
    List<PoiTextStyle>? textStyle,
    PoiTransition? textTransition,
  }) {
    final otherStyle = PoiStyle(

      zoomLevel: zoomLevel
    );
  }
  
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
    return payload;
  }
}
