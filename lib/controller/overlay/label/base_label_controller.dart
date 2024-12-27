part of '../../../flutter_kakao_map.dart';

class _BaseLabelController extends OverlayController {
  @override
  final MethodChannel channel;

  final CompetitionType competitionType;
  final CompetitionUnit competitionUnit;
  final OrderingType orderingType;

  bool _visible;
  bool get visible => _visible;

  bool _clickable;
  bool get clickable => _clickable;

  int _zOrder;
  int get zOrder => _zOrder;

  final Map<String, Poi> _poi = {};

  @override
  OverlayType get type => OverlayType.label;

  _BaseLabelController(this.channel, {
    required this.competitionType,
    required this.competitionUnit,
    required this.orderingType,
    int zOrder = _BaseLabelController.defaultZOrder,
    bool visible = true,
    bool clickable = true
  }) : _zOrder = zOrder, _visible = visible, _clickable = clickable;

  Future<void> _createLabelLayer() async {
    await _invokeMethod("createLabelLayer", {
      "layerId": id,
      "competitionType": competitionType.value,
      "competitionUnit": competitionUnit.value,
      "orderingType": orderingType.value,
      "zOrder": zOrder,
      "visable": _visible,
      "clickable": _clickable,
    });
  }

  static const int defaultZOrder = 10001;
  static const CompetitionType defaultCompetitionType = CompetitionType.none;
  static const CompetitionUnit defaultCompetitionUnit = CompetitionUnit.iconAndText;
  static const OrderingType defaultOrderingType = OrderingType.rank;
}
