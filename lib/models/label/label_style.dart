part of '../../flutter_kakao_map.dart';

class LabelStyle {
  final bool applyDpScale;
  final KPoint anchor;
  final double padding;
  final LabelTransition iconTransition;
  final int textGravity;
  final KImage? icon;
  final LabelTextStyle textStyle;
  final LabelTransition textTransition;
  final int zoomLevel;

  LabelStyle({
    this.applyDpScale = true,
    this.anchor = const KPoint(0.5, 1.0),
    this.padding = 0,
    this.icon,
    this.iconTransition = const LabelTransition(),
    this.textGravity = 8,
    this.textStyle = const LabelTextStyle(),
    this.textTransition = const LabelTransition(),
    this.zoomLevel = 0
  });
}
