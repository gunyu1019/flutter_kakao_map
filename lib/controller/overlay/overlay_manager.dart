part of '../../flutter_kakao_map.dart';

mixin OverlayManager {
  late MethodChannel overlayChannel;

  // Label
  final Map<String, LabelController> _labelController = {};
  final Map<String, List<PoiStyle>> _poiStyle = {};

  Future<String> addPoiStyle(List<PoiStyle> styles, [String? id]);

  Future<String> _validatePoiStyle(List<PoiStyle>? styles, [String? id]);

  void _initalizeOverlayController() {
    _labelController[_defaultKey] = LabelController._(
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

  LabelController? getLabelLayer(String id);

  LabelController get defaultLabelLayer;

  static const String _defaultKey = 'default';
}
