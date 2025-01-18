part of '../flutter_kakao_map.dart';

class KakaoMapController with KakaoMapControllerSender, OverlayManager {
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
  Future<String> addPoiStyle(List<PoiStyle> styles, [String? id]) async {
    String styleId = await defaultLabelLayer._invokeMethod("addPoiStyle", {
      "styleId": id,
      "styles": styles.map((e) => e.toMessageable()).toList()
    });
    _poiStyle[styleId] = styles;
    return styleId;
  }

  @override
  Future<String> _validatePoiStyle(List<PoiStyle>? styles, [String? id]) async {
    String? styleId = id;
    if (styles != null) {
      styleId = await addPoiStyle(styles, id);
    }

    if (styleId == null) {
      throw Exception("Missing a style at Label.");
    }
    return styleId;
  }

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
