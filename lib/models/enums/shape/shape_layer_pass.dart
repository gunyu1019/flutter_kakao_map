part of '../../../flutter_kakaomaps.dart';

enum ShapeLayerPass {
  defaultPass(0),
  overlayPass(1),
  routePass(2);

  final int value;

  const ShapeLayerPass(this.value);
}
