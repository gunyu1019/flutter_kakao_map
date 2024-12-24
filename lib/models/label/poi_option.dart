part of '../../flutter_kakao_map.dart';

class PoiOption {
  final LatLng position;
  final bool clickable;
  final String? text;
  final int rank;
  final String tag;
  final List<PoiStyle> styles;
  final TransformMethod? transform;
  final bool visable;

  PoiOption(this.position, {
    this.clickable = false,
    this.text,
    this.tag = "",
    this.rank = 0,
    this.styles = const [],
    this.transform,
    this.visable = true
  });
}
