part of '../../../kakao_map_sdk.dart';

enum Transition {
  none(0),
  alpha(1),
  scale(2);

  final int value;

  const Transition(this.value);
}
