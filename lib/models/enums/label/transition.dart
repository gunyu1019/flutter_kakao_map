part of '../../../kakao_map_sdk.dart';

/// [Poi] 또는 [LodPoi]가 나타나고, 사라질 때 적용하는 애니메이션을 정의합니다.
enum Transition {
  /// 나타나거나 사라질 때 애니메이션을 적용하지 않습니다.
  none(0),

  /// 점점 나타나거나 점점 사라지는 애니메이션을 적용합니다.
  alpha(1),

  /// 점점 커지거나 점점 작아지는 애니메이션을 적용합니다.
  scale(2);

  final int value;

  const Transition(this.value);
}
