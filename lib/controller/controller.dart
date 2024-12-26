part of '../flutter_kakao_map.dart';

class KakaoMapController with KakaoMapControllerSender {
  final MethodChannel channel;
  final MethodChannel labelChannel;

  KakaoMapController(this.channel, {required this.labelChannel});

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

  /* Sender(Label) */
  LabelController get defaultLabelLayer =>
      LabelController(LabelController.defaultId, labelChannel,
          competitionType: LabelController.defaultCompetitionType,
          competitionUnit: LabelController.defaultCompetitionUnit,
          orderingType: LabelController.defaultOrderingType,
          zOrder: LabelController.defaultZOrder);

  Future<LabelController> addLabelLayer(String id,
      {CompetitionType competitionType = LabelController.defaultCompetitionType,
      CompetitionUnit competitionUnit = LabelController.defaultCompetitionUnit,
      OrderingType orderingType = LabelController.defaultOrderingType,
      int zOrder = LabelController.defaultZOrder}) async {
    final labelLayer = LabelController(
      id,
      labelChannel,
      competitionType: competitionType,
      competitionUnit: competitionUnit,
      orderingType: orderingType,
      zOrder: zOrder,
    );
    await labelLayer._createLabelLayer();
    return labelLayer;
  }
}
