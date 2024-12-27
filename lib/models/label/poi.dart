part of '../../flutter_kakao_map.dart';

class Poi {
  final LabelController _controller;
  final String? id;
  
  final TransformMethod? transform;
  LatLng position;
  bool clickable;
  String? text;
  int rank;
  String? styleId;
  List<PoiStyle>? styles;
  bool visible;
}
