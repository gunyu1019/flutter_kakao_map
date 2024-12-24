part of '../../../flutter_kakao_map.dart';

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
