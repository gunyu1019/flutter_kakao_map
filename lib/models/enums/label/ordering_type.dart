part of '../../../kakao_map_sdk.dart';

/// 우선순위가 같은 Label끼리 경쟁하는 경우, 경쟁하는 순위를 정의합니다.
enum OrderingType {
  /// [Poi]가 가지고 있는 rank의 값이 높을수록 우선순위를 가집니다.
  rank(0),

  /// [Poi]가 화면 좌측 하단에 가까울수록 높은 우선순위를 가집니다.
  leftBottom(1);

  final int value;

  const OrderingType(this.value);
}
