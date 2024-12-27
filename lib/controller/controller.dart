part of '../flutter_kakao_map.dart';

class KakaoMapController with KakaoMapControllerSender {
  final MethodChannel channel;
  final MethodChannel overlayChannel;

  KakaoMapController(this.channel, {required this.overlayChannel}) {
    _initOverlay();
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
  
  /* Overlay */
  Map<String, LabelController> labelController = {};

  void _initOverlay() {
    labelController['default'] = LabelController(
      LabelController.defaultId, 
      overlayChannel, 
      competitionType: LabelController.defaultCompetitionType,
      competitionUnit: LabelController.defaultCompetitionUnit,
      orderingType: LabelController.defaultOrderingType,
    );
  }

  /* Sender(Label) */
  Future<LabelController> addLabelLayer(String id,
      {CompetitionType competitionType = LabelController.defaultCompetitionType,
      CompetitionUnit competitionUnit = LabelController.defaultCompetitionUnit,
      OrderingType orderingType = LabelController.defaultOrderingType,
      int zOrder = LabelController.defaultZOrder}) async {
    final labelLayer = LabelController(
      id,
      overlayChannel,
      competitionType: competitionType,
      competitionUnit: competitionUnit,
      orderingType: orderingType,
      zOrder: zOrder,
    );
    await labelLayer._createLabelLayer();
    return labelLayer;
  }

  LabelController? getLabelLayer(String id) => labelController[id];

  LabelController defaultLabelLayer(String id) => labelController['default']!;
}
