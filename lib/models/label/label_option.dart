part of '../../flutter_kakao_map.dart';

class LabelOption {
  final LatLng position;
  final bool clickable;
  final String? text;
  final int rank;
  final String tag;
  final List<LabelStyle> styles;
  final bool visable;

  LabelOption(this.position, {
    this.clickable = false,
    this.text,
    this.tag = "",
    this.rank = 0,
    this.styles = const [],
    this.visable = true
  });
}
