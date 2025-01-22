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
}
