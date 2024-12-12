part of '../flutter_kakao_map.dart';

class KakaoMapOption {
  final LatLng position;
  final int zoomLevel;
  final MapType mapType;
  final String? viewName;
  final bool visible;
  final String? tag;

  const KakaoMapOption({
    this.position = defaultPosition,
    this.zoomLevel = defaultZoomLevel,
    this.mapType = defaultMapType,
    this.viewName,
    this.visible = defaultVisible,
    this.tag
  });

  /* Default Type */
  static const defaultPosition = LatLng(37.402005, 127.108621);
  static const defaultZoomLevel = 15;
  static const defaultMapType = MapType.normal;
  static const defaultVisible = true;
}