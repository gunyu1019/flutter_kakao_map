part of '../../flutter_kakao_map.dart';

mixin OverlayManager {
  late MethodChannel overlayChannel;

  // Label
  final Map<String, LabelController> _labelController = {};
  final Map<String, List<PoiStyle>> _poiStyle = {};

  Future<String> addPoiStyle(List<PoiStyle> styles, [String? id]);

  void _initalizeOverlayController() {
    _labelController[_defaultKey] = LabelController._(
      overlayChannel,
      this,
      LabelController.defaultId,
      competitionType: LabelController.defaultCompetitionType,
      competitionUnit: LabelController.defaultCompetitionUnit,
      orderingType: LabelController.defaultOrderingType,
    );
  }

  Future<LabelController> addLabelLayer(String id,
      {CompetitionType competitionType = LabelController.defaultCompetitionType,
      CompetitionUnit competitionUnit = LabelController.defaultCompetitionUnit,
      OrderingType orderingType = LabelController.defaultOrderingType,
      int zOrder = LabelController.defaultZOrder});

  LabelController? getLabelLayer(String id);

  LabelController get defaultLabelLayer;

  static const String _defaultKey = 'default';
}
