part of '../../kakao_map.dart';

class LabelController extends BaseLabelController {
  @override
  MethodChannel channel;

  @override
  OverlayManager manager;

  @override
  OverlayType get type => OverlayType.label;

  @override
  final String id;

  final Map<String, Poi> _poi = {};
  final Map<String, PolylineText> _polylineText = {};

  LabelController._(this.channel, this.manager, this.id,
      {competitionType = BaseLabelController.defaultCompetitionType,
      competitionUnit = BaseLabelController.defaultCompetitionUnit,
      orderingType = BaseLabelController.defaultOrderingType,
      bool visible = true,
      bool clickable = false,
      int zOrder = BaseLabelController.defaultZOrder})
      : super._(competitionType, competitionUnit, orderingType, visible,
            clickable, zOrder);

  Future<void> _createLabelLayer() async {
    await _invokeMethod("createLabelLayer", {
      "competitionType": competitionType.value,
      "competitionUnit": competitionUnit.value,
      "orderingType": orderingType.value,
      "zOrder": zOrder,
      "visable": visible,
      "clickable": _clickable,
    });
  }

  Future<void> _removeLabelLayer() async {
    await _invokeMethod("removeLabelLayer", {});
  }

  Future<void> _changePoiOffsetPosition(
      String poiId, double x, double y, bool forceDpScale) async {
    await _invokeMethod("changePoiOffsetPosition",
        {"poiId": poiId, "x": x, "y": y, "forceDpScale": forceDpScale});
  }

  Future<void> _changePoiVisible(String poiId, bool visible) async {
    await _invokeMethod(
        "changePoiVisible", {"poiId": poiId, "visible": visible});
  }

  Future<void> _changePoiStyle(String poiId, String styleId) async {
    await _invokeMethod("changePoiStyle", {"poiId": poiId, "styleId": styleId});
  }

  Future<void> _changePoiText(String poiId, String text) async {
    await _invokeMethod("changePoiText", {"poiId": poiId, "text": text});
  }

  Future<void> _invalidatePoi(String poiId, String styleId, String? text,
      [bool transition = false]) async {
    await _invokeMethod("invalidatePoi", {
      "poiId": poiId,
      "styleId": styleId,
      "text": text,
      "transition": transition
    });
  }

  Future<void> _movePoi(String poiId, LatLng position, [double? millis]) async {
    final payload = {"poiId": poiId, "millis": millis};
    payload.addAll(position.toMessageable());
    await _invokeMethod("movePoi", payload);
  }

  Future<void> _rotatePoi(String poiId, double angle, [double? millis]) async {
    await _invokeMethod(
        "rotatePoi", {"poiId": poiId, "angle": angle, "millis": millis});
  }

  Future<void> _scalePoi(String poiId, double x, double y,
      [double? millis]) async {
    await _invokeMethod(
        "scalePoi", {"poiId": poiId, "x": x, "y": y, "millis": millis});
  }

  Future<void> _rankPoi(String poiId, int rank) async {
    await _invokeMethod("rankPoi", {"poiId": poiId, "rank": rank});
  }

  Future<void> _changePolylineTextStyle(String poiId, PolylineTextStyle style,
      [String? text]) async {
    await _invokeMethod("changePolylineTextStyle",
        {"poiId": poiId, "styles": style.toMessageable(), "text": text});
  }

  Future<void> _changePolylineTextVisible(String labelId, bool visible) async {
    await _invokeMethod(
        "changePolylineTextVisible", {"labelId": labelId, "visible": visible});
  }

  Future<Poi> addPoi(
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
        style: style,
        text: text,
        rank: rank ?? 0,
        visible: visible,
        onClick: onClick);
    _poi[poiId] = poi;
    return poi;
  }

  Poi? getPoi(String id) {
    return _poi[id];
  }

  Future<void> removePoi(Poi poi) async {
    await _invokeMethod("removePoi", {
      "poiId": poi.id,
    });
    _poi.remove(poi.id);
  }

  Future<void> showAllPoi() async {
    await _invokeMethod("changeVisibleAllPoi", {"visible": true});
  }

  Future<void> hideAllPoi() async {
    await _invokeMethod("changeVisibleAllPoi", {"visible": false});
  }

  Future<PolylineText> addPolylineText(
    String text,
    List<LatLng> position, {
    required PolylineTextStyle style,
    String? id,
    bool visible = true,
  }) async {
    Map<String, dynamic> payload = {
      "label": <String, dynamic>{
        "position": position.map((e) => e.toMessageable()).toList(),
        "style": style.toMessageable(),
        "id": id,
        "text": text,
        "visible": visible
      }
    };
    String labelId = await _invokeMethod("addPolylineText", payload);
    final label = PolylineText._(this, labelId,
        style: style, text: text, points: position);
    _polylineText[labelId] = label;
    return label;
  }

  PolylineText? getPolylineText(String id) {
    return _polylineText[id];
  }

  Future<void> removePolylineText(PolylineText label) async {
    await _invokeMethod("removePolylineText", {
      "labelId": label.id,
    });
    _polylineText.remove(label.id);
  }

  Future<void> showAllPolylineText() async {
    await _invokeMethod("changeVisibleAllPolylineText", {"visible": true});
  }

  Future<void> hideAllPolylineText() async {
    await _invokeMethod("changeVisibleAllPolylineText", {"visible": false});
  }

  int get poiCount => _poi.length;
  int get polylineCount => _polylineText.length;

  static const String defaultId = "label_default_layer";
}
