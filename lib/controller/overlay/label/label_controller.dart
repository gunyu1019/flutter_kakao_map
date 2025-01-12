part of '../../../flutter_kakao_map.dart';

class LabelController extends OverlayController {
  @override
  MethodChannel channel;

  @override
  OverlayManager manager;

  @override
  OverlayType get type => OverlayType.label;

  final String id;

  final CompetitionType competitionType;
  final CompetitionUnit competitionUnit;
  final OrderingType orderingType;

  bool _visible;
  bool get visible => _visible;

  bool _clickable;
  bool get clickable => _clickable;

  int _zOrder;
  int get zOrder => _zOrder;

  final Map<String, Poi> _poi = {};

  LabelController._(this.channel, this.manager, this.id,
      {this.competitionType = defaultCompetitionType,
      this.competitionUnit = defaultCompetitionUnit,
      this.orderingType = defaultOrderingType,
      bool visible = true,
      bool clickable = false,
      int zOrder = defaultZOrder})
      : _visible = visible,
        _clickable = clickable,
        _zOrder = zOrder;

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

  Future<void> _changePoiOffsetPosition(
      String poiId, double x, double y, bool forceDpScale) async {
    await _invokeMethod("changePoiOffsetPosition", {
      "layerId": id,
      "poiId": poiId,
      "x": x,
      "y": y,
      "forceDpScale": forceDpScale
    });
  }

  Future<void> _changePoiVisible(
      String poiId, bool visible) async {
    await _invokeMethod("changePoiVisible", {
      "layerId": id,
      "poiId": poiId,
      "visible": visible
    });
  }

  Future<void> _changePoiStyle(
      String poiId, String styleId) async {
    await _invokeMethod("changePoiStyle", {
      "layerId": id,
      "poiId": poiId,
      "styleId": styleId
    });
  }

  Future<void> _changePoiText(
      String poiId, String text) async {
    await _invokeMethod("changePoiText", {
      "layerId": id,
      "poiId": poiId,
      "text": text
    });
  }

  Future<void> _invalidate({
    String? id,
    String? text,
    String? styleId,
    List<PoiStyle>? styles,
    int? rank,
    bool clickable = false,
    bool visible = true,
  }) async {
  }

  Future<Poi> addPoi(
    LatLng position, {
    String? id,
    String? text,
    String? styleId,
    List<PoiStyle>? styles,
    TransformMethod? transform,
    int? rank,
    void Function()? onClick,
    bool visible = true,
  }) async {
    styleId = await manager._validatePoiStyle(styles, styleId);

    Map<String, dynamic> payload = {
      "poi": <String, dynamic>{
        "clickable": onClick != null,
        "text": text,
        "rank": rank,
        "styleId": styleId,
        "transform": transform?.value,
        "visible": visible,
      }
    };
    payload["poi"].addAll(position.toMessageable());
    String poiId = await _invokeMethod("addPoi", payload);
    final poi = Poi._(this, poiId,
        transform: transform,
        position: position,
        clickable: clickable,
        styleId: styleId,
        styles: manager._poiStyle[styleId]!,
        text: text,
        rank: rank ?? 0,
        visible: visible);
    _poi[poiId] = poi;
    return poi;
  }

  static const String defaultId = "label_default_layer";
  static const int defaultZOrder = 10001;
  static const CompetitionType defaultCompetitionType = CompetitionType.none;
  static const CompetitionUnit defaultCompetitionUnit =
      CompetitionUnit.iconAndText;
  static const OrderingType defaultOrderingType = OrderingType.rank;
}
