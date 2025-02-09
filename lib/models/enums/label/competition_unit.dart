part of '../../../kakao_map_sdk.dart';

/// Poi 간에서 경쟁 처리 단위를 정의합니다.
enum CompetitionUnit {
  /// Poi가 아이콘과 텍스트 경쟁에서 모두 통과해야 그려집니다.
  iconAndText(0),

  /// Poi가 아이콘만 경쟁에서 통과해도 그려집니다.
  /// 다만, Text가 경쟁에서 진 경우 텍스트만 그려지지 않습니다.
  iconFirst(1);

  final int value;

  const CompetitionUnit(this.value);
}
