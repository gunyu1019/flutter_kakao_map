part of '../../flutter_kakao_map.dart';

mixin OverlayManager {
  late MethodChannel overlayChannel;

  // Label
  final Map<String, LabelController> _labelController = {};
  final Map<String, LodLabelController> _lodLabelController = {};
  final Map<String, PoiStyle> _poiStyle = {};

  Future<String> addPoiStyle(PoiStyle style);

  PoiStyle? getPoiStyle(String id);

  // void removePoiStyle(String id);

  void _initalizeOverlayController() {
    _labelController[_defaultKey] = LabelController._(
      overlayChannel,
      this,
      LabelController.defaultId,
      competitionType: BaseLabelController.defaultCompetitionType,
      competitionUnit: BaseLabelController.defaultCompetitionUnit,
      orderingType: BaseLabelController.defaultOrderingType,
    );
    _lodLabelController[_defaultKey] = LodLabelController._(
      overlayChannel,
      this,
      LabelController.defaultId,
      competitionType: BaseLabelController.defaultCompetitionType,
      competitionUnit: BaseLabelController.defaultCompetitionUnit,
      orderingType: BaseLabelController.defaultOrderingType,
    );
  }

  Future<LabelController> addLabelLayer(String id,
      {CompetitionType competitionType = BaseLabelController.defaultCompetitionType,
      CompetitionUnit competitionUnit = BaseLabelController.defaultCompetitionUnit,
      OrderingType orderingType = BaseLabelController.defaultOrderingType,
      int zOrder = BaseLabelController.defaultZOrder});

  Future<LodLabelController> addLodLabelLayer(String id,
      {CompetitionType competitionType = BaseLabelController.defaultCompetitionType,
      CompetitionUnit competitionUnit = BaseLabelController.defaultCompetitionUnit,
      OrderingType orderingType = BaseLabelController.defaultOrderingType,
      double radius = LodLabelController.defaultRadius,
      int zOrder = BaseLabelController.defaultZOrder});

  LabelController? getLabelLayer(String id);

  LodLabelController? getLodLabelLayer(String id);

  Future<void> removeLabelLayer(LabelController controller);

  Future<void> removeLodLabelLayer(LodLabelController controller);

  LabelController get defaultLabelLayer;

  LodLabelController get defaultLodLabelLayer;

  static const String _defaultKey = 'default';
}
