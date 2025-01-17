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
  final Map<String, PolylineText> _polylineText = {};

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

  @override
  Future<T> _invokeMethod<T>(String method, Map<String, dynamic> payload) {
    payload['layerId'] = id;
    return super._invokeMethod(method, payload);
  }

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
      "poiId": poiId,
      "x": x,
      "y": y,
      "forceDpScale": forceDpScale
    });
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

  Future<void> _invalidatePoi(
      String poiId, String styleId, String? text, [bool transition = false]) async {
    await _invokeMethod("invalidatePoi", {
      "poiId": poiId,
      "styleId": styleId,
      "text": text,
      "transition": transition
    });
  }

  Future<void> _movePoi(
      String poiId, LatLng position, [double? millis]) async {
    final payload = {
      "poiId": poiId,
      "millis": millis
    };
    payload.addAll(position.toMessageable());
    await _invokeMethod("movePoi", payload);
  }

  Future<void> _rotatePoi(
      String poiId, double angle, [double? millis]) async {
    await _invokeMethod("rotatePoi", {
      "poiId": poiId,
      "angle": angle,
      "millis": millis
    });
  }

  Future<void> _scalePoi(
      String poiId, double x, double y, [double? millis]) async {
    await _invokeMethod("scalePoi", {
      "poiId": poiId,
      "x": x,
      "y": y,
      "millis": millis
    });
  }

  Future<void> _rankPoi(
      String poiId, int rank) async {
    await _invokeMethod("rankPoi", {
      "poiId": poiId,
      "rank": rank
    });
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

  Poi? getPoi(String id) {
    return _poi[id];
  }

  Future<void> removePoi(Poi poi) async {
    await _invokeMethod("removePoi", {
      "poiId": poi.id,
    });
    _poi.remove(poi.id);
  }

  Future<PolylineText> addPolylineText(
    String text, 
    List<LatLng> position, {
      required List<PolylineTextStyle> styles,
      String? id,
      bool visible = true,
  }) async {
    Map<String, dynamic> payload = {
      "label": <String, dynamic>{
        "position": position.map((e) => e.toMessageable()).toList(),
        "styles": styles.map((e) => e.toMessageable()).toList(),
        "id": id,
        "text": text,
        "visible": visible
      }
    };
    String labelId = await _invokeMethod("addPloylineText", payload);
    final label = PolylineText._(this, labelId, styles: styles, text: text, points: position);
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

  int get poiCount => _poi.length;
  int get polylineCount => _polylineText.length;

  static const String defaultId = "label_default_layer";
  static const int defaultZOrder = 10001;
  static const CompetitionType defaultCompetitionType = CompetitionType.none;
  static const CompetitionUnit defaultCompetitionUnit =
      CompetitionUnit.iconAndText;
  static const OrderingType defaultOrderingType = OrderingType.rank;
}
