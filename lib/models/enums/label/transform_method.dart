part of '../../../kakao_map_sdk.dart';

/// [Poi]가 카메라의 움직임에 따라 어떤 자세를 취할지 정의합니다.
enum TransformMethod {
  one(-1),

  /// 지도가 어떤 방향으로 회전하든 [Poi]가 가지고 있는 고유의 회전 방향을 유지한다.
  absoluteRoatation(0),

  /// [Poi]가 어떤 방향으로 회전하든 항상 위쪽 방향을 유지한다.
  following(1), // default

  /// 지도가 어떤 방향으로 회전하든 [Poi]는 항상 고유의 회전 방향을 가지며, 텍스트도 항상 스크린의 위쪽 방향을 유지한다.
  absoluteRotationKeepUpright(2),

  /// 지도가 어떤 방향으로 회전하고 기울든 [Poi]는 항상 고유의 회전 방향을 유지합니다.
  absoluteRotationDecal(3),

  /// [Poi]가 지도의 기울기에 따라 움직이도록 한다.
  decal(4);

  final int value;

  const TransformMethod(this.value);
}
