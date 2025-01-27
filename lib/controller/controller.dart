part of '../flutter_kakao_map.dart';

class KakaoMapController extends KakaoMapControllerSender with OverlayManager {
  final MethodChannel channel;

  @override
  final MethodChannel overlayChannel;

  KakaoMapController(this.channel, {required this.overlayChannel}) {
    _initalizeOverlayController();
  }

  /* Sender */
  @override
  Future<CameraPosition> getCameraPosition() async {
    final rawCameraPosition = await channel.invokeMethod("getCameraPosition");
    return CameraPosition.fromMessageable(rawCameraPosition);
  }

  @override
  Future<void> moveCamera(CameraUpdate camera,
      {CameraAnimation? animation}) async {
    await channel.invokeMethod("moveCamera", {
      "cameraUpdate": camera.toMessageable(),
      "cameraAnimation": animation?.toMessageable()
    });
  }

  @override
  Future<String> addPoiStyle(PoiStyle style) async {
    String styleId = await labelLayer._invokeMethod(
        "addPoiStyle", {"styleId": style.id, "styles": style.toMessageable()});
    style._setStyleId(styleId);
    _poiStyle[styleId] = style;
    return styleId;
  }

  @override
  Future<String> addPolygonShapeStyle(PolygonStyle style) async {
    final styleIds = await addMultiplePolygonShapeStyle([style], style.id);
    return styleIds;
  }

  @override
  Future<String> addPolylineShapeStyle(PolylineStyle style) async {
    final styleIds = await addMultiplePolylineShapeStyle([style], style.id);
    return styleIds;
  }

  @override
  Future<String> addMultiplePolygonShapeStyle(List<PolygonStyle> style,
      [String? id]) async {
    String styleId = await shapeLayer._invokeMethod("addPolygonShapeStyle", {
      "styleId": id,
      "styles": style.map((e) => e.toMessageable()).toList()
    });
    style.map((e) => e._setStyleId(styleId));
    _polygonStyle[styleId] = style;
    return styleId;
  }

  @override
  Future<String> addMultiplePolylineShapeStyle(List<PolylineStyle> style,
      [String? id]) async {
    String styleId = await shapeLayer._invokeMethod("addPolylineShapeStyle", {
      "styleId": id,
      "styles": style.map((e) => e.toMessageable()).toList(),
      "polylineCap": style[0].polylineCap?.value
    });
    style.map((e) => e._setStyleId(styleId));
    _polylineStyle[styleId] = style;
    return styleId;
  }

  @override
  PoiStyle? getPoiStyle(String id) => _poiStyle[id];

  @override
  PolygonStyle? getPolygonShapeStyle(String id) => _polygonStyle[id]?[0];

  @override
  PolylineStyle? getPolylineShapeStyle(String id) => _polylineStyle[id]?[0];

  @override
  List<PolygonStyle>? getMultiplePolygonShapeStyle(String id) =>
      _polygonStyle[id];

  @override
  List<PolylineStyle>? getMultiplePolylineShapeStyle(String id) =>
      _polylineStyle[id];

  @override
  Future<LabelController> addLabelLayer(String id,
      {CompetitionType competitionType =
          BaseLabelController.defaultCompetitionType,
      CompetitionUnit competitionUnit =
          BaseLabelController.defaultCompetitionUnit,
      OrderingType orderingType = BaseLabelController.defaultOrderingType,
      int zOrder = BaseLabelController.defaultZOrder}) async {
    final labelLayer = LabelController._(
      overlayChannel,
      this,
      id,
      competitionType: competitionType,
      competitionUnit: competitionUnit,
      orderingType: orderingType,
      zOrder: zOrder,
    );
    await labelLayer._createLabelLayer();
    _labelController[id] = labelLayer;
    return labelLayer;
  }

  @override
  Future<LodLabelController> addLodLabelLayer(String id,
      {CompetitionType competitionType =
          BaseLabelController.defaultCompetitionType,
      CompetitionUnit competitionUnit =
          BaseLabelController.defaultCompetitionUnit,
      OrderingType orderingType = BaseLabelController.defaultOrderingType,
      double radius = LodLabelController.defaultRadius,
      int zOrder = BaseLabelController.defaultZOrder}) async {
    final labelLayer = LodLabelController._(
      overlayChannel,
      this,
      id,
      competitionType: competitionType,
      competitionUnit: competitionUnit,
      orderingType: orderingType,
      radius: radius,
      zOrder: zOrder,
    );
    await labelLayer._createLodLabelLayer();
    _lodLabelController[id] = labelLayer;
    return labelLayer;
  }

  @override
  Future<ShapeController> addShapeLayer(String id,
      {ShapeLayerPass passType = ShapeController.defaultShapeLayerPass,
      int zOrder = ShapeController.defaultZOrder}) async {
    final shapeLayer = ShapeController._(overlayChannel, this, id,
        passType: passType, zOrder: zOrder);
    await shapeLayer._createShapeLayer();
    _shapeController[id] = shapeLayer;
    return shapeLayer;
  }

  @override
  LabelController? getLabelLayer(String id) => _labelController[id];

  @override
  LodLabelController? getLodLabelLayer(String id) => _lodLabelController[id];

  @override
  ShapeController? getShapeLayer(String id) => _shapeController[id];

  @override
  Future<void> removeLabelLayer(LabelController controller) async {
    await controller._removeLabelLayer();
  }

  @override
  Future<void> removeLodLabelLayer(LodLabelController controller) async {
    await controller._removeLodLabelLayer();
  }

  @override
  Future<void> removeShapeLayer(ShapeController controller) async {
    await controller._removeShapeLayer();
  }

  @override
  LabelController get labelLayer =>
      _labelController[OverlayManager._defaultKey]!;

  @override
  LodLabelController get lodLabelLayer =>
      _lodLabelController[OverlayManager._defaultKey]!;

  @override
  ShapeController get shapeLayer =>
      _shapeController[OverlayManager._defaultKey]!;
}
