part of '../../flutter_kakao_maps.dart';

mixin OverlayManager {
  late MethodChannel overlayChannel;

  // Label
  final Map<String, LabelController> _labelController = {};
  final Map<String, LodLabelController> _lodLabelController = {};
  final Map<String, ShapeController> _shapeController = {};
  final Map<String, RouteController> _routeController = {};

  final Map<String, PoiStyle> _poiStyle = {};
  final Map<String, List<PolygonStyle>> _polygonStyle = {};
  final Map<String, List<PolylineStyle>> _polylineStyle = {};
  final Map<String, List<RouteStyle>> _routeStyle = {};

  Future<String> addPoiStyle(PoiStyle style);

  PoiStyle? getPoiStyle(String id);

  Future<String> addPolygonShapeStyle(PolygonStyle style);

  Future<String> addPolylineShapeStyle(PolylineStyle style, PolylineCap polylineCap);

  PolygonStyle? getPolygonShapeStyle(String id);

  PolylineStyle? getPolylineShapeStyle(String id);

  Future<String> addMultiplePolygonShapeStyle(List<PolygonStyle> style,
      [String? id]);

  Future<String> addMultiplePolylineShapeStyle(List<PolylineStyle> style, PolylineCap polylineCap,
      [String? id]);

  List<PolygonStyle>? getMultiplePolygonShapeStyle(String id);

  List<PolylineStyle>? getMultiplePolylineShapeStyle(String id);

  Future<String> addRouteStyle(RouteStyle style);

  RouteStyle? getRotueStyle(String id);

  Future<String> addMultipleRouteStyle(List<RouteStyle> style, [String? id]);

  List<RouteStyle>? getMultipleRotueStyle(String id);

  void _initalizeOverlayController() {
    _labelController[_defaultKey] =
        LabelController._(overlayChannel, this, LabelController.defaultId);
    _lodLabelController[_defaultKey] =
        LodLabelController._(overlayChannel, this, LodLabelController.defaultId);
    _shapeController[_defaultKey] =
        ShapeController._(overlayChannel, this, ShapeController.defaultId);
    _routeController[_defaultKey] =
        RouteController._(overlayChannel, this, RouteController.defaultId);
  }

  Future<LabelController> addLabelLayer(String id,
      {CompetitionType competitionType =
          BaseLabelController.defaultCompetitionType,
      CompetitionUnit competitionUnit =
          BaseLabelController.defaultCompetitionUnit,
      OrderingType orderingType = BaseLabelController.defaultOrderingType,
      int zOrder = BaseLabelController.defaultZOrder});

  Future<LodLabelController> addLodLabelLayer(String id,
      {CompetitionType competitionType =
          BaseLabelController.defaultCompetitionType,
      CompetitionUnit competitionUnit =
          BaseLabelController.defaultCompetitionUnit,
      OrderingType orderingType = BaseLabelController.defaultOrderingType,
      double radius = LodLabelController.defaultRadius,
      int zOrder = BaseLabelController.defaultZOrder});

  Future<ShapeController> addShapeLayer(String id,
      {ShapeLayerPass passType = ShapeController.defaultShapeLayerPass,
      int zOrder = ShapeController.defaultZOrder});

  Future<RouteController> addRouteLayer(String id,
      {int zOrder = RouteController.defaultZOrder});

  LabelController? getLabelLayer(String id);

  LodLabelController? getLodLabelLayer(String id);

  ShapeController? getShapeLayer(String id);

  RouteController? getRouteLayer(String id);

  Future<void> removeLabelLayer(LabelController controller);

  Future<void> removeLodLabelLayer(LodLabelController controller);

  Future<void> removeShapeLayer(ShapeController controller);

  Future<void> removeRouteLayer(RouteController controller);

  LabelController get labelLayer;

  LodLabelController get lodLabelLayer;

  ShapeController get shapeLayer;

  RouteController get routeLayer;

  static const String _defaultKey = 'default';
}
