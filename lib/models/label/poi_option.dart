part of '../../flutter_kakao_map.dart';

class PoiOption {
  final String? id;
  LatLng position;
  bool clickable;
  String? text;
  int rank;
  String tag;
  String? styleId;
  List<PoiStyle>? styles;
  TransformMethod? transform;
  bool visible;

  PoiOption(this.position, {
    this.id,
    this.clickable = false,
    this.text,
    this.tag = "",
    this.rank = 0,
    this.styleId,
    this.styles,
    this.transform,
    this.visible = true
  });
  
  Map<String, dynamic> toMessageable() {
    final payload = <String, dynamic>{
      "clickable": clickable,
      "text": text,
      "tag": tag,
      "rank": rank,
      "styleId": styleId,
      "styles": styles?.map((element) => element.toMessageable()).toList(),
      "transform": transform?.value,
      "visible": visible,
    };
    payload.addAll(position.toMessageable());
    return payload;
  }
}
