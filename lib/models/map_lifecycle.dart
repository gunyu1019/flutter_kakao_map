part of '../kakao_map_sdk.dart';

/// 지도의 상태관리를 관리하는 Mixin 객체입니다.
mixin KakaoMapLifecycle {
  /// 지도가 삭제되면 호출되는 인수입니다.
  void Function()? onMapDestroy;

  /// 지도가 일시정지되면 호출되는 인수입니다.
  void Function()? onMapPaused;

  /// 지도가 일시정지에서 풀리면 호출되는 함수입니다.
  void Function()? onMapResumed;
}
