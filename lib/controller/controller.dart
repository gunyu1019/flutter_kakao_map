part of '../flutter_kakao_maps.dart';

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
  Future<LatLng> fromScreenPoint(double x, double y) async {
    final position =
        await channel.invokeMethod("fromScreenPoint", {"x": x, "y": y});
    return LatLng.fromMessageable(position);
  }

  @override
  Future<KPoint> toScreenPoint(LatLng position) async {
    final point =
        await channel.invokeMethod("toScreenPoint", position.toMessageable());
    return KPoint(point['x'], point['y']);
  }

  @override
  Future<void> setGesture(GestureType gesture, bool enable) async {
    await channel.invokeMethod("setGestureEnable", {
      "gestureType": gesture.value,
      "enable": enable
    });
  }
  

  @override
  Future<void> clearCache() async {
    await channel.invokeMethod("clearCache");
  }

  @override
  Future<void> clearDiskCache() async {
    await channel.invokeMethod("clearDiskCache");
  }

  @override
  Future<bool> canShowPosition(int zoomLevel, List<LatLng> position) async {
    final result = await channel.invokeMethod("canShowPosition", {
      "zoomLevel": zoomLevel,
      "position": position.map((e) => e.toMessageable()).toList()
    });
    return result;
  }

  @override
  Future<void> changeMapType(MapType mapType) async {
    await channel.invokeMethod("changeMapType", {
      "mapType": mapType.value
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
  Future<String> addPolylineShapeStyle(
      PolylineStyle style, PolylineCap polylineCap) async {
    final styleIds =
        await addMultiplePolylineShapeStyle([style], polylineCap, style.id);
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
  Future<String> addMultiplePolylineShapeStyle(
      List<PolylineStyle> style, PolylineCap polylineCap,
      [String? id]) async {
    String styleId = await shapeLayer._invokeMethod("addPolylineShapeStyle", {
      "styleId": id,
      "styles": style.map((e) => e.toMessageable()).toList(),
      "polylineCap": polylineCap.value
    });
    style.map((e) => e._setStyleId(styleId));
    _polylineStyle[styleId] = style;
    return styleId;
  }

  @override
  Future<String> addRouteStyle(RouteStyle style) async {
    final styleIds = await addMultipleRouteStyle([style], style.id);
    return styleIds;
  }

  @override
  Future<String> addMultipleRouteStyle(List<RouteStyle> styles,
      [String? id]) async {
    String styleId = await routeLayer._invokeMethod("addRouteStyle", {
      "styleId": id,
      "styles": styles.map((e) => e.toMessageable()).toList()
    });
    styles.map((e) => e._setStyleId(styleId));
    _routeStyle[styleId] = styles;
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
  RouteStyle? getRotueStyle(String id) => _routeStyle[id]?[0];

  @override
  List<RouteStyle>? getMultipleRotueStyle(String id) => _routeStyle[id];

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
  Future<RouteController> addRouteLayer(String id,
      {int zOrder = ShapeController.defaultZOrder}) async {
    final routeLayer =
        RouteController._(overlayChannel, this, id, zOrder: zOrder);
    await routeLayer._createRouteLayer();
    _routeController[id] = routeLayer;
    return routeLayer;
  }

  @override
  LabelController? getLabelLayer(String id) => _labelController[id];

  @override
  LodLabelController? getLodLabelLayer(String id) => _lodLabelController[id];

  @override
  ShapeController? getShapeLayer(String id) => _shapeController[id];

  @override
  RouteController? getRouteLayer(String id) => _routeController[id];

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
  Future<void> removeRouteLayer(RouteController controller) async {
    await controller._removeRouteLayer();
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

  @override
  RouteController get routeLayer =>
      _routeController[OverlayManager._defaultKey]!;
}
