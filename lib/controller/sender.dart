part of '../flutter_kakao_maps.dart';

abstract class KakaoMapControllerSender {
  Future<CameraPosition> getCameraPosition();

  Future<void> moveCamera(CameraUpdate camera, {CameraAnimation? animation});

  Future<LatLng> fromScreenPoint(double x, double y);

  Future<KPoint> toScreenPoint(LatLng position);

  // Future<void> clearCache();

  // Future<void> clearDiskCache();

  // Future<bool> canShowPosition(int zoomLevel, List<LatLng> position);

  // Future<void> changeMapType(MapType mapType);

  // Future<void> setGesture(GestureType gesture, bool enable);
}
