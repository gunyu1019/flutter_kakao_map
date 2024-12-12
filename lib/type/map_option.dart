part of '../flutter_kakao_map.dart';

class KakaoMapOption {
  final int initialPosition;
  final int zoomLevel;
  final MapType mapType;
  final String? viewName;
  final bool visible;
  final String? tag;

  const KakaoMapOption({
    this.initialPosition,
    this.zoomLevel = defaultZoomLevel,
    this.mapType = defaultMapType,
    this.viewName,
    this.visible = defaultVisible,
    this.tag
  });

  /* Default Type */
  static const defaultZoomLevel = 15;
  static const defaultMapType = MapType.normal;
  static const defaultVisible = true;
}