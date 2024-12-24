part of '../../flutter_kakao_map.dart';

class LabelLayer {
  final String id;
  final bool isLodLayer;
  final CompetitionType competitionType;
  final CompetitionUnit competitionUnit;
  final OrderingType orderingType;
  bool visable;
  bool clickable;
  String tag;
  int zOrder;

  LabelLayer({
    this.id = defaultLabelLayerId,
    required this.isLodLayer,
    required this.competitionType,
    required this.competitionUnit,
    required this.orderingType,
    required this.zOrder, // 10001 (default)
    this.visable = true,
    this.clickable = true,
    this.tag = ""
  });

  void addPoi() {
    // TODO (Thinking Logic... Too Many MethodChannel..??) 
  }

  static const String defaultLabelLayerId = "label_default_layer";
}
