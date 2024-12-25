part of '../flutter_kakao_map.dart';

class KakaoMapController with KakaoMapControllerSender {
  final MethodChannel channel;
  final MethodChannel labelChannel;

  KakaoMapController(this.channel, {
    required this.labelChannel
  }) {
    defaultLabelLayer = LabelController(
      LabelController.layerLabelDefaultId, 
      labelChannel,
      competitionType: CompetitionType.none,
      competitionUnit: CompetitionUnit.iconAndText,
      orderingType: OrderingType.rank,
      zOrder: LabelController.layerLabelDefaultZOrder
    );
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

  /* Sender(Label) */
  late LabelController defaultLabelLayer;

  Future<LabelController> addLabelLayer(String id, {
    CompetitionType competitionType = CompetitionType.none,
    CompetitionUnit competitionUnit = CompetitionUnit.iconAndText,
    OrderingType orderingType = OrderingType.rank,
    int zOrder = LabelController.layerLabelDefaultZOrder
  }) async {
    final labelLayer = LabelController(
      LabelController.layerLabelDefaultId, 
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
