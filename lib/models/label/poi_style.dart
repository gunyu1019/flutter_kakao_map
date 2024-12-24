part of '../../flutter_kakao_map.dart';

class PoiStyle {
  final bool applyDpScale;
  final KPoint anchor;
  final double padding;
  final PoiTransition iconTransition;
  final int textGravity;
  final KImage? icon;
  final PoiTextStyle textStyle;
  final PoiTransition textTransition;
  final int zoomLevel;

  PoiStyle({
    this.applyDpScale = true,
    this.anchor = const KPoint(0.5, 1.0),
    this.padding = 0,
    this.icon,
    this.iconTransition = const PoiTransition(),
    this.textGravity = 8,
    this.textStyle = const PoiTextStyle(),
    this.textTransition = const PoiTransition(),
    this.zoomLevel = 0
  });
}
