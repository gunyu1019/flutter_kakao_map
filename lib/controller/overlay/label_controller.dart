part of '../../flutter_kakao_map.dart';

class LabelController extends OverlayController {
  final String id;

  @override
  final MethodChannel channel;

  final CompetitionType competitionType;
  final CompetitionUnit competitionUnit;
  final OrderingType orderingType;
  bool visable;
  bool clickable;
  String tag;
  int zOrder;

  @override
  OverlayType get type => OverlayType.label;

  LabelController(this.id, this.channel, {
    required this.competitionType,
    required this.competitionUnit,
    required this.orderingType,
    required this.zOrder,
    this.visable = true,
    this.clickable = true,
    this.tag = ""
  });

  Future<void> _createLabelLayer() async {
    await invokeMethod("createLabelLayer", {
      "layerId": id,
      "competitionType": competitionType.value,
      "competitionUnit": competitionUnit.value,
      "orderingType": orderingType.value,
      "zOrder": zOrder,
      "visable": visable,
      "clickable": clickable,
      "tag": tag,
    });
  }

  Future<void> addPoi(PoiOption poi) async {
    await invokeMethod("addPoi", {
      "layerId": id,
      "poi": poi.toMessageable()
    });
  }

  static const String layerLabelDefaultId = "label_default_layer";
  static const int layerLabelDefaultZOrder = 10001;
}
