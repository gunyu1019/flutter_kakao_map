part of '../../flutter_kakao_map.dart';

class LodLabelController extends BaseLabelController {
  @override
  MethodChannel channel;

  @override
  OverlayManager manager;

  @override
  OverlayType get type => OverlayType.lodLabel;

  @override
  final String id;

  final double radius;

  final Map<String, LodPoi> _poi = {};

  LodLabelController._(this.channel, this.manager, this.id,
      {competitionType = BaseLabelController.defaultCompetitionType,
      competitionUnit = BaseLabelController.defaultCompetitionUnit,
      orderingType = BaseLabelController.defaultOrderingType,
      this.radius = LodLabelController.defaultRadius,
      bool visible = true,
      bool clickable = false,
      int zOrder = BaseLabelController.defaultZOrder,
      })
      : super._(competitionType, competitionUnit, orderingType, visible, clickable, zOrder);

  Future<void> _createLodLabelLayer() async {
    await _invokeMethod("createLodLabelLayer", {
      "layerId": id,
      "competitionType": competitionType.value,
      "competitionUnit": competitionUnit.value,
      "orderingType": orderingType.value,
      "radius": radius,
      "zOrder": zOrder,
      "visable": visible,
      "clickable": _clickable,
    });
  }
  
  Future<void> _removeLodLabelLayer() async {
    await _invokeMethod("removeLabelLayer", {});
  }


  Future<void> _changePoiVisible(
      String poiId, bool visible) async {
    await _invokeMethod("changePoiVisible", {
      "poiId": poiId,
      "visible": visible
    });
  }

  Future<void> _changePoiStyle(
      String poiId, String styleId) async {
    await _invokeMethod("changePoiStyle", {
      "poiId": poiId,
      "styleId": styleId
    });
  }

  Future<void> _changePoiText(
      String poiId, String text) async {
    await _invokeMethod("changePoiText", {
      "poiId": poiId,
      "text": text
    });
  }

  Future<void> _rankPoi(
      String poiId, int rank) async {
    await _invokeMethod("rankPoi", {
      "poiId": poiId,
      "rank": rank
    });
  }

  Future<LodPoi> addLodPoi(
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
    final poi = LodPoi._(this, poiId,
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

  LodPoi? getLodPoi(String id) {
    return _poi[id];
  }

  Future<void> removeLodPoi(LodPoi poi) async {
    await _invokeMethod("removePoi", {
      "poiId": poi.id,
    });
    _poi.remove(poi.id);
  }

  Future<void> showAllLodPoi() async {
    await _invokeMethod("changeVisibleAllLodPoi", {"visible": true});
  }

  Future<void> hideAllLodPoi() async {
    await _invokeMethod("changeVisibleAllLodPoi", {"visible": false});
  }

  int get poiCount => _poi.length;
  
  static const String defaultId = "lod_label_default_layer";
  static const double defaultRadius = 0.0;
}
