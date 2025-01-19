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
    String styleId = await defaultLabelLayer._invokeMethod("addPoiStyle", {
      "styleId": style.id,
      "styles": style.toMessageable()
    });
    style._setStyleId(styleId);
    _poiStyle[styleId] = style;
    return styleId;
  }

  @override
  PoiStyle? getPoiStyle(String id) => _poiStyle[id];

  @override
  Future<LabelController> addLabelLayer(String id,
      {CompetitionType competitionType = BaseLabelController.defaultCompetitionType,
      CompetitionUnit competitionUnit = BaseLabelController.defaultCompetitionUnit,
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
      {CompetitionType competitionType = BaseLabelController.defaultCompetitionType,
      CompetitionUnit competitionUnit = BaseLabelController.defaultCompetitionUnit,
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
  LabelController? getLabelLayer(String id) => _labelController[id];

  @override
  LodLabelController? getLodLabelLayer(String id) => _lodLabelController[id];

  @override
  Future<void> removeLabelLayer(LabelController controller) async {
    await controller._removeLabelLayer();
  }

  @override
  Future<void> removeLodLabelLayer(LodLabelController controller) async {
    await controller._removeLodLabelLayer();
  }

  @override
  LabelController get defaultLabelLayer => _labelController[OverlayManager._defaultKey]!;

  @override
  LodLabelController get defaultLodLabelLayer => _lodLabelController[OverlayManager._defaultKey]!;

  /* Sender(Label) */
}
