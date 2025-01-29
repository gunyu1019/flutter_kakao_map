part of '../flutter_kakao_maps.dart';

abstract class KakaoMapControllerSender {
  /// 현재 카메라가 보고 있는 속성을 불러옵니다.
  /// [CameraPosition] 형태로 반환하며, 카메라가 보고 있는 위치, 확대/축소, 회전, 기울기 값을 반환받는다.
  Future<CameraPosition> getCameraPosition();

  /// 카메라를 이동시켜 지도를 움직인다.
  /// [animation] 매개변수를 입력하면 이동 애니메이션을 가지게된다.
  Future<void> moveCamera(CameraUpdate camera, {CameraAnimation? animation});

  Future<LatLng> fromScreenPoint(double x, double y);

  Future<KPoint> toScreenPoint(LatLng position);

  Future<void> setGesture(GestureType gesture, bool enable);

  // Future<void> clearCache();

  // Future<void> clearDiskCache();

  // Future<bool> canShowPosition(int zoomLevel, List<LatLng> position);

  // Future<void> changeMapType(MapType mapType);

  // 
}
