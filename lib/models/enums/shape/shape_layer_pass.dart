part of '../../../kakao_map_sdk.dart';

enum ShapeLayerPass {
  defaultPass(0),
  overlayPass(1),
  routePass(2);

  final int value;

  const ShapeLayerPass(this.value);
}
