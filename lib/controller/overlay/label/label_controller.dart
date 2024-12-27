part of '../../../flutter_kakao_map.dart';

class LabelController extends _BaseLabelController {
  final String id;

  final Map<String, Poi> _poi = {};

  @override
  Future<T> _invokeMethod<T>(String method, Map<String, dynamic> payload) {
    payload['layerId'] = id;
    return super._invokeMethod(method, payload);
  }

  LabelController(this.id, super.channel, {
    required super.competitionType,
    required super.competitionUnit,
    required super.orderingType,
    super.zOrder,
    super.visible,
    super.clickable
  });

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

  Future<void> addPoi(LatLng position, {
    String? id,
    String? text,
    String? styleId,
    List<PoiStyle>? styles,
    TransformMethod? transform,
    int? rank,
    void Function()? onClick,
    bool clickable = false,
    bool visible = true,
  }) async {
    if (styles != null) {
      styleId = await addPoiStyle(styles, styleId);
    }
    Map<String, dynamic> payload = {
      "poi": <String, dynamic>{
        "clickable": onClick != null || clickable, 
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
}
