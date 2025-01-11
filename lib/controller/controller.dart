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
  Future<LabelController> addLabelLayer(String id,
      {CompetitionType competitionType = LabelController.defaultCompetitionType,
      CompetitionUnit competitionUnit = LabelController.defaultCompetitionUnit,
      OrderingType orderingType = LabelController.defaultOrderingType,
      int zOrder = LabelController.defaultZOrder}) async {
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
  LabelController? getLabelLayer(String id) => _labelController[id];

  @override
  LabelController get defaultLabelLayer => _labelController[OverlayManager._defaultKey]!;

  /* Sender(Label) */
}
