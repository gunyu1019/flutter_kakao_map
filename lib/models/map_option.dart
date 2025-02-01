part of '../flutter_kakao_maps.dart';

/// 지도를 시작될 때, 지도의 기본 정보를 정의하는 객체입니다.
class KakaoMapOption {
  /// 지도가 시작하면 카메라가 비출 위치를 설정합니다.
  /// 기본 값은 카카오 판교캠퍼스입니다.
  final LatLng position;

  /// 지도가 시작하면 카메라의 확대/축소 값입니다.
  final int zoomLevel;

  /// 지도의 유형입니다.
  final MapType mapType;

  /// 지도 객체의 ViewName을 정의합니다.
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