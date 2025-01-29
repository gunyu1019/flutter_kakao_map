part of '../../flutter_kakao_maps.dart';

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
    await _invokeMethod("removeLodLabelLayer", {});
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
    required PoiStyle style,
    String? id,
    String? text,
    TransformMethod? transform,
    int? rank,
    void Function()? onClick,
    bool visible = true,
  }) async {
    final styleId = style.id ?? await manager.addPoiStyle(style);
    Map<String, dynamic> payload = {
      "poi": <String, dynamic>{
        "id": id,
        "clickable": onClick != null,
        "text": text,
        "rank": rank,
        "styleId": styleId,
        "transform": transform?.value,
        "visible": visible,
      }
    };
    payload["poi"].addAll(position.toMessageable());
    String poiId = await _invokeMethod("addLodPoi", payload);
    final poi = LodPoi._(this, poiId,
        transform: transform,
        position: position,
        clickable: clickable,
        style: style,
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
    await _invokeMethod("removeLodPoi", {
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
  
  static const String defaultId = "lodLabel_default_layer";
  static const double defaultRadius = 20.0;
}
