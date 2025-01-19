part of '../flutter_kakao_map.dart';

abstract class KakaoMapControllerSender {
  Future<CameraPosition> getCameraPosition();

  Future<void> moveCamera(CameraUpdate camera, {CameraAnimation? animation});
}
