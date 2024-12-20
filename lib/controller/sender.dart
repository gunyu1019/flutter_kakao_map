part of '../flutter_kakao_map.dart';

mixin KakaoMapControllerSender {
  Future<CameraPosition> getCameraPosition();

  Future<void> moveCamera(CameraUpdate camera, {CameraAnimation? animation});
  
  Future<void> setGestureEnable(GestureType gestrueType, bool enable);
}
