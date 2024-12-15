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
  static const LatLng defaultPosition = LatLng(37.402005, 127.108621);
  static const int defaultZoomLevel = 15;
  static const MapType defaultMapType = MapType.normal;
  static const bool defaultVisible = true;

  Map<String, dynamic> toMessageable() {
    final payload = <String, dynamic>{
      "zoomLevel": zoomLevel,
      "mapType": mapType.value,
      "viewName": viewName,
      "visible": visible,
      "tag": tag,
    };
    payload.addAll(position.toMessageable());
    return payload;
  }
}