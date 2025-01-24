part of '../../flutter_kakao_map.dart';

class ShapeController extends OverlayController {
  @override
  MethodChannel channel;

  @override
  OverlayManager manager;

  @override
  OverlayType get type => OverlayType.shape;

  @override
  final String id;

  ShapeController._(this.channel, this.manager, this.id);
    
  static const String defaultId = "shape_default_layer";

  @override
  Future<T> _invokeMethod<T>(String method, Map<String, dynamic> payload) {
    payload['layerId'] = id;
    return super._invokeMethod(method, payload);
  }

  Future<Polyline> addPolylineShape<T extends _BasePoint>(T position, PolylineStyle style) async {
    final payload = <String, dynamic>{
      "polyline": <String, dynamic>{
        "position": position.toMessageable(),
        "style": style.toMessageable()
      }
    };
    String shapeId = await _invokeMethod("addPolylineShape", payload);
    final polyline = Polyline._(this, shapeId, position: position, style: style);
    return polyline;
  }
  
  Future<Polygon> addPolygonShape<T extends _BasePoint>(T position, PolygonStyle style) async {
    final payload = <String, dynamic>{
      "polygon": <String, dynamic>{
        "position": position.toMessageable(),
        "style": style.toMessageable()
      }
    };
    String shapeId = await _invokeMethod("addPolygonShape", payload);
    final polygon = Polygon._(this, shapeId, position: position, style: style);
    return polygon;
  }
}
