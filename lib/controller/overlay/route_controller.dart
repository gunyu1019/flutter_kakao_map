part of '../../flutter_kakao_maps.dart';

class RouteController extends OverlayController {
  @override
  MethodChannel channel;

  @override
  OverlayManager manager;

  @override
  OverlayType get type => OverlayType.route;

  final String id;
  final int zOrder;

  final Map<String, Route> _route = {};
  final Map<String, MultipleRoute> _multiple_route = {};

  RouteController._(this.channel, this.manager, this.id,
      {this.zOrder = defaultZOrder});

  Future<void> _createRouteLayer() async {
    await _invokeMethod("createRouteLayer", {"zOrder": zOrder});
  }

  Future<void> _removeRouteLayer() async {
    await _invokeMethod("removeRouteLayer", {});
  }

  @override
  Future<T> _invokeMethod<T>(String method, Map<String, dynamic> payload) {
    payload['layerId'] = id;
    return super._invokeMethod(method, payload);
  }

  Future<Route> addRoute(List<LatLng> points, RouteStyle style,
      {String? id, CurveType curveType = CurveType.none}) async {
    final styleId = style.id ?? await manager.addRouteStyle(style);
    Map<String, dynamic> payload = {
      "route": <String, dynamic>{
        "id": id,
        "points": points.map((e) => e.toMessageable()).toList(),
        "styleId": styleId,
        "curveType": curveType.value
      }
    };
    String routeId = await _invokeMethod("addRoute", payload);
    final route = Route._(this, routeId,
        points: points, style: style, curveType: curveType);
    _route[routeId] = route;
    return route;
  }

  Future<MultipleRoute> addMultipleRoute(MultipleRouteOption option) async {
    if (!option._isStyleAdded()) {
      await manager.addMultipleRouteStyle(option._styles);
    }
    Map<String, dynamic> payload = {"route": option.toMessageable()};
    String routeId = await _invokeMethod("addMultipleRoute", payload);
    final route = MultipleRoute._(this, routeId,
        points: option._points,
        style: option._styles,
        curveType: option._curveType,
        styleIndex: option._styleIndex);
    _multiple_route[routeId] = route;
    return route;
  }

  static const String defaultId = "route_layer_0";
  static const int defaultZOrder = 10000;
}
