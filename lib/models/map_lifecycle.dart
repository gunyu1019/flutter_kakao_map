part of '../flutter_kakao_map.dart';

class KakaoMapLifecycle {
  final void Function()? onMapDestroy;
  final void Function()? onMapPaused;
  final void Function()? onMapResumed;

  const KakaoMapLifecycle(
      {this.onMapDestroy, this.onMapPaused, this.onMapResumed});
}
