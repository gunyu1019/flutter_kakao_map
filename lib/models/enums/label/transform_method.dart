part of '../../../kakao_map_sdk.dart';

enum TransformMethod {
  one(-1),
  absoluteRoatation(0),
  following(1), // default
  absoluteRotationKeepUpright(2),
  absoluteRotationDecal(3),
  decal(4);

  final int value;

  const TransformMethod(this.value);
}
