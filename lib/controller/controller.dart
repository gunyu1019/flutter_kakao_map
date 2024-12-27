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
  Map<String, LabelController> _labelController = {};

  void _initOverlay() {
    _labelController['default'] = LabelController(
      LabelController.defaultId, 
      overlayChannel, 
      competitionType: _BaseLabelController.defaultCompetitionType,
      competitionUnit: _BaseLabelController.defaultCompetitionUnit,
      orderingType: _BaseLabelController.defaultOrderingType,
    );
  }
  
  final Map<String, List<PoiStyle>> _poiStyle = {};

  Future<String> addPoiStyle(List<PoiStyle> styles, [String? id]) async {
    String styleId = await _BaseLabelController._invokeMethod("addPoiStyle", {
      "styleId": id,
      "styles": styles.map((e) => e.toMessageable()).toList()
    });
    _poiStyle[styleId] = styles;
    return styleId;
  }

  /* Sender(Label) */
  Future<LabelController> addLabelLayer(String id,
      {CompetitionType competitionType = _BaseLabelController.defaultCompetitionType,
      CompetitionUnit competitionUnit = _BaseLabelController.defaultCompetitionUnit,
      OrderingType orderingType = _BaseLabelController.defaultOrderingType,
      int zOrder = _BaseLabelController.defaultZOrder}) async {
    final labelLayer = LabelController(
      id,
      overlayChannel,
      competitionType: competitionType,
      competitionUnit: competitionUnit,
      orderingType: orderingType,
      zOrder: zOrder,
    );
    await labelLayer._createLabelLayer();
    _labelController[id] = labelLayer;
    return labelLayer;
  }

  LabelController? getLabelLayer(String id) => _labelController[id];

  LabelController defaultLabelLayer(String id) => _labelController['default']!;
}
