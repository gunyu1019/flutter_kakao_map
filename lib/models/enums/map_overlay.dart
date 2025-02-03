part of '../../flutter_kakao_maps.dart';

/// 지도에 사용되는 오버레이 객체입니다.
enum MapOverlay {
  /// 자전거 도로
  bicycleRoad(value: "BICYCLE_ROAD"),

  /// 로드뷰라인
  roadviewLine(value: "ROADVIEW_LINE"),

  /// 지형도
  hillsading(value: "HILLSHADING"),

  /// (스카이뷰 한정) 도로선
  hybrid(value: "SKYVIEW_HYBRID");
  
  final String value;
  
  const MapOverlay({required this.value});
}