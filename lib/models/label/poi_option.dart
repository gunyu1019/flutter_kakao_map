part of '../../flutter_kakao_map.dart';

class PoiOption {
  LatLng position;
  bool clickable;
  String? text;
  int rank;
  String tag;
  List<PoiStyle> styles;
  TransformMethod? transform;
  bool visable;

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
