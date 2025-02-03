part of '../../../flutter_kakao_maps.dart';

/// [LabelController] 간 우선순위를 설정할 수 있는 클래스입니다.
enum CompetitionType {
  none(0),
  all(1),
  upper(2),
  upperLower(3),
  upperSame(4),
  same(5),
  sameLower(6),
  lower(7);

  final int value;

  const CompetitionType(this.value);
}
