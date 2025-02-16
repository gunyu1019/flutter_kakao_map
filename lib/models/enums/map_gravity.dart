part of '../../kakao_map_sdk.dart';

/// 지도에 개체(나침판 등)을 배치하기 위한 기준을 설정합니다.
enum MapGravity {
  /// 지도의 왼쪽 부분
  left(value: 1),

  /// 지도의 오른쪽 부분
  right(value: 2),

  /// 지도의 위쪽 부분
  top(value: 4),

  /// 지도의 맨 아래 부분
  bottom(value: 8),

  /// 지도의 중앙 부분
  center(value: 16),

  /// 지도의 가로에서 중앙 부분
  centerHorizontal(value: 32),

  /// 지도의 세로에서 중앙부분
  centerVertical(value: 64);

  final int value;

  const MapGravity({required this.value});
}
