part of '../flutter_kakao_map.dart';

mixin KakaoMapLifecycle {
  void Function()? onMapDestroy;
  void Function()? onMapPaused;
  void Function()? onMapResumed;
}
