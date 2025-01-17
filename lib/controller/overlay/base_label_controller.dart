part of '../../flutter_kakao_map.dart';

abstract class BaseLabelController extends OverlayController {
  abstract final String id;

  final CompetitionType competitionType;
  final CompetitionUnit competitionUnit;
  final OrderingType orderingType;

  bool _visible;
  bool get visible => _visible;

  bool _clickable;
  bool get clickable => _clickable;

  int _zOrder;
  int get zOrder => _zOrder;

  BaseLabelController._(
    this.competitionType, 
    this.competitionUnit, 
    this.orderingType,
    bool visible,
    bool clickable,
    int zOrder
  ) : _visible = visible, _clickable = clickable, _zOrder = zOrder;

  @override
  Future<T> _invokeMethod<T>(String method, Map<String, dynamic> payload) {
    payload['layerId'] = id;
    return super._invokeMethod(method, payload);
  }

  static const int defaultZOrder = 10001;
  static const CompetitionType defaultCompetitionType = CompetitionType.none;
  static const CompetitionUnit defaultCompetitionUnit =
      CompetitionUnit.iconAndText;
  static const OrderingType defaultOrderingType = OrderingType.rank;
}