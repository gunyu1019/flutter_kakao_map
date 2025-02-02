part of '../../flutter_kakao_maps.dart';

/// 오버레이(Poi, 도형, 경로선 등)을 관리할 때 사용하는 객체입니다.
mixin OverlayManager {
  late MethodChannel overlayChannel;

  // Controller
  final Map<String, LabelController> _labelController = {};
  final Map<String, LodLabelController> _lodLabelController = {};
  final Map<String, ShapeController> _shapeController = {};
  final Map<String, RouteController> _routeController = {};
  // final DimController _dimController;
  // final TrackingController _trackingController;

  // Overlay Style
  final Map<String, PoiStyle> _poiStyle = {};
  final Map<String, List<PolygonStyle>> _polygonStyle = {};
  final Map<String, List<PolylineStyle>> _polylineStyle = {};
  final Map<String, List<RouteStyle>> _routeStyle = {};

  /// Poi 스타일을 등록합니다. [style] 매개변수에는 Poi에 사용될 스타일 객체([PoiStyle])가 입력됩니다.
  /// 등록한 Poi 스타일은 [Poi]와 [LodPoi]에서 사용할 수 있습니다. 
  /// 메소드를 사용하면 등록된 스타일의 고유ID가 반환됩니다.
  Future<String> addPoiStyle(PoiStyle style);

  /// 고유 ID를 통해 Poi 스타일 객체를 불러옵니다.
  PoiStyle? getPoiStyle(String id);

  /// Polygon Shape 스타일을 등록합니다. [style] 매개변수에는 Polygon 도형에서 사용될 스타일 객체([PolygonStyle])이 입력됩니다.
  /// 등록된 Polygon Shape 스타일은 [PolygonShape]에서 사용됩니다.
  /// 메소드를 사용하면 등록된 스타일의 고유ID가 반환됩니다.
  Future<String> addPolygonShapeStyle(PolygonStyle style);

  /// Polygon Shape 스타일을 등록합니다. [style] 매개변수에는 Polygon 도형에서 사용될 스타일 객체([PolylineStyle])이 입력됩니다.
  /// 등록된 Polygon Shape 스타일은 [PolylineShape]에서 사용됩니다.
  /// [polylineCap] 매개변수는 Polyline 도형의 꼭지점을 설정합니다.
  /// 메소드를 사용하면 등록된 스타일의 고유ID가 반환됩니다.
  Future<String> addPolylineShapeStyle(PolylineStyle style, PolylineCap polylineCap);

  /// 고유 ID를 통해 Polygon Shape 스타일 객체를 불러옵니다.
  PolygonStyle? getPolygonShapeStyle(String id);

  /// 고유 ID를 통해 Polyline Shape 스타일 객체를 불러옵니다.
  PolylineStyle? getPolylineShapeStyle(String id);

  /// Multiple Polygon Shape의 스타일을 등록합니다. [style] 매개변수에는 다중 Polygon 도형에 사용될 스타일 객체를 배열 형태로 입력합니다.
  /// ID 값은 [id] 매개변수를 주어서 사전에 정의할 수 있지만, 입력하지 않으면 임의로 생성된 고유ID가 반환됩니다.
  Future<String> addMultiplePolygonShapeStyle(List<PolygonStyle> style,
      [String? id]);

  /// Multiple Polyline Shape의 스타일을 등록합니다. [style] 매개변수에는 다중 Polyline 도형에 사용될 스타일 객체를 배열 형태로 입력합니다.
  /// ID 값은 [id] 매개변수를 주어서 사전에 정의할 수 있지만, 입력하지 않으면 임의로 생성된 고유ID가 반환됩니다.
  Future<String> addMultiplePolylineShapeStyle(List<PolylineStyle> style, PolylineCap polylineCap,
      [String? id]);

  /// 고유 ID를 통해 Multiple Polygon 스타일 객체를 불러옵니다.
  List<PolygonStyle>? getMultiplePolygonShapeStyle(String id);

  /// 고유 ID를 통해 Multiple Polyline 스타일 객체를 불러옵니다.
  List<PolylineStyle>? getMultiplePolylineShapeStyle(String id);

  /// Route 스타일을 등록합니다. [style] 매개변수에는 경로선 스타일에 사용되는 스타일 객체([RouteStyle])가 입력됩니다.
  /// 등록된 Route Style은 [Route]에서 사용됩니다.
  /// 메소드를 사용하면 등록된 스타일의 고유ID가 반환됩니다.
  Future<String> addRouteStyle(RouteStyle style);

  /// 고유 ID를 통해 Route 스타일 객체를 불러옵니다.
  RouteStyle? getRotueStyle(String id);

  /// 다중 Route 스타일을 등록합니다. [style] 매개변수에는 경로선 스타일에 사용되는 스타일 객체([RouteStyle])가 배열 형태로 입력됩니다.
  /// 등록된 Route Style은 [MultipleRoute]에서 사용됩니다. 
  /// ID 값은 [id] 매개변수를 주어서 사전에 정의할 수 있지만, 입력하지 않으면 임의로 생성된 고유ID가 반환됩니다.
  /// 배열에 등록된 순서로 [MultipleRouteOption.addRouteWithIndex] 메소드에서 index 값으로 경로선의 스타일을 정의할 수 있습니다.
  Future<String> addMultipleRouteStyle(List<RouteStyle> styles, [String? id]);

  /// 고유 ID를 통해 Multiple Route 스타일 객체를 불러옵니다.
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
