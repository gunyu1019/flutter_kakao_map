part of '../../flutter_kakao_map.dart';

class ShapeController extends OverlayController {
  @override
  MethodChannel channel;

  @override
  OverlayManager manager;

  @override
  OverlayType get type => OverlayType.shape;

  final String id;
  final ShapeLayerPass passType;
  final int zOrder;

  ShapeController._(this.channel, this.manager, this.id, {
    this.passType = defaultShapeLayerPass,
    this.zOrder = defaultZOrder
  });

  Future<void> _createShapeLayer() async {
    await _invokeMethod("createShapeLayer", {
      "passType": passType.value,
      "zOrder": zOrder
    });
  }
  
  Future<void> _removeShapeLayer() async {
    await _invokeMethod("removeShapeLayer", {});
  }

  @override
  Future<T> _invokeMethod<T>(String method, Map<String, dynamic> payload) {
    payload['layerId'] = id;
    return super._invokeMethod(method, payload);
  }

  Future<Polyline> addPolylineShape<T extends _BasePoint>(T position, PolylineStyle style) async {
    final styleId = style._id ?? await manager.addPolylineShapeStyle(style);
    final payload = <String, dynamic>{
      "polyline": <String, dynamic>{
        "position": position.toMessageable(),
        "styleId": styleId
      }
    };
    String shapeId = await _invokeMethod("addPolylineShape", payload);
    final polyline = Polyline._(this, shapeId, position: position, style: style);
    return polyline;
  }
  
  Future<Polygon> addPolygonShape<T extends _BasePoint>(T position, PolygonStyle style) async {
    final styleId = style._id ?? await manager.addPolygonShapeStyle(style);
    final payload = <String, dynamic>{
      "polygon": <String, dynamic>{
        "position": position.toMessageable(),
        "styleId": styleId
      }
    };
    String shapeId = await _invokeMethod("addPolygonShape", payload);
    final polygon = Polygon._(this, shapeId, position: position, style: style);
    return polygon;
  }
    
  static const String defaultId = "vector_layer_0";
  static const int defaultZOrder = 10000;
  static const ShapeLayerPass defaultShapeLayerPass = ShapeLayerPass.defaultPass;
}
