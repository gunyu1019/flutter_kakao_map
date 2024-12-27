part of '../../flutter_kakao_map.dart';

class LabelController extends OverlayController {
  final String id;

  @override
  final MethodChannel channel;

  final CompetitionType competitionType;
  final CompetitionUnit competitionUnit;
  final OrderingType orderingType;

  bool _visible;
  bool get visible => _visible;

  bool _clickable;
  bool get clickable => _clickable;

  int _zOrder;
  int get zOrder => _zOrder;

  @override
  OverlayType get type => OverlayType.label;

  @override
  Future<T> _invokeMethod<T>(String method, Map<String, dynamic> payload) {
    payload['layerId'] = id;
    return super._invokeMethod(method, payload);
  }

  LabelController(this.id, this.channel, {
    required this.competitionType,
    required this.competitionUnit,
    required this.orderingType,
    int zOrder = LabelController.defaultZOrder,
    bool visible = true,
    bool clickable = true
  }) : _zOrder = zOrder, _visible = visible, _clickable = clickable;

  Future<void> _createLabelLayer() async {
    await _invokeMethod("createLabelLayer", {
      "layerId": id,
      "competitionType": competitionType.value,
      "competitionUnit": competitionUnit.value,
      "orderingType": orderingType.value,
      "zOrder": zOrder,
      "visable": _visible,
      "clickable": _clickable,
    });
  }

  Future<String> addPoiStyle(List<PoiStyle> styles, [String? id]) async {
    String styleId = await _invokeMethod("addPoiStyle", {
      "styleId": id,
      "styles": styles.map((e) => e.toMessageable()).toList()
    });
    return styleId;
  }

  Future<void> addPoi(LatLng position, {
    String? id,
    String? text,
    String? styleId,
    List<PoiStyle>? styles,
    TransformMethod? transform,
    int? rank,
    bool clickable = false,
    bool visible = true,
  }) async {
    if (styles != null) {
      styleId = await addPoiStyle(styles, styleId);
    }
    Map<String, dynamic> payload = {
      "poi": <String, dynamic>{
        "clickable": clickable,
        "text": text,
        "rank": rank,
        "styleId": styleId,
        "transform": transform?.value,
        "visible": visible,
      }
    };
    payload["poi"].addAll(position.toMessageable());
    String poiId = await _invokeMethod("addPoi", payload);
  }

  static const String defaultId = "label_default_layer";
  static const int defaultZOrder = 10001;
  static const CompetitionType defaultCompetitionType = CompetitionType.none;
  static const CompetitionUnit defaultCompetitionUnit = CompetitionUnit.iconAndText;
  static const OrderingType defaultOrderingType = OrderingType.rank;
}
