part of '../../flutter_kakao_map.dart';

class RouteController extends OverlayController {
  @override
  MethodChannel channel;

  @override
  OverlayManager manager;

  @override
  OverlayType get type => OverlayType.route;

  final String id;
  final int zOrder;

  RouteController._(this.channel, this.manager, this.id, {
    this.zOrder = defaultZOrder
  });

  Future<void> _createRouteLayer() async {
    await _invokeMethod("createRouteLayer", {
      "zOrder": zOrder
    });
  }
  
  Future<void> _removeRouteLayer() async {
    await _invokeMethod("removeRouteLayer", {});
  }

  @override
  Future<T> _invokeMethod<T>(String method, Map<String, dynamic> payload) {
    payload['layerId'] = id;
    return super._invokeMethod(method, payload);
  }

  Future<void> addRoute(List<LatLng> points, RouteStyle style, {
    String? id,
    CurvedType curvedType = CurvedType.none
  }) async {
    final styleId = style.id ?? await manager.addRouteStyle(style);
    Map<String, dynamic> payload = {
      "route": <String, dynamic>{
        "id": id,
        "points": points.map((e) => e.toMessageable()).toList(),
        "styleId": styleId,
        "curvedType": curvedType.value
      }
    };
    String routeId = await _invokeMethod("addRoute", payload);
  }
    
  static const String defaultId = "route_layer_0";
  static const int defaultZOrder = 10000;
}
