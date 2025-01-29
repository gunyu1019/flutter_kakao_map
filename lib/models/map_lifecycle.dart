part of '../flutter_kakao_maps.dart';

mixin KakaoMapLifecycle {
  void Function()? onMapDestroy;
  void Function()? onMapPaused;
  void Function()? onMapResumed;
}
