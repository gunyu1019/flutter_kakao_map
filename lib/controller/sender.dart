part of '../flutter_kakao_maps.dart';

abstract class KakaoMapControllerSender {
  /// 현재 카메라가 보고 있는 속성을 불러옵니다.
  /// [CameraPosition] 형태로 반환하며, 카메라가 보고 있는 위치, 확대/축소, 회전, 기울기 값을 반환받는다.
  Future<CameraPosition> getCameraPosition();

  /// 카메라를 이동시켜 지도를 움직인다.
  /// [animation] 매개변수를 입력하면 이동 애니메이션을 가지게된다.
  Future<void> moveCamera(CameraUpdate camera, {CameraAnimation? animation});

  /// 주어진 [x]와 [y] 값이 지도의 위/경도로 어디에 속해있는지 반환합니다.
  Future<LatLng> fromScreenPoint(double x, double y);

  /// 주어진 [position] 매개변수를 통해 스크린의 x 좌표와 y 좌표 값을 [KPoint]에 담아 반환합니다.
  Future<KPoint> toScreenPoint(LatLng position);

  /// 지도에서 사용할 수 있는 제스처를 설정합니다.
  /// [gesture]는 사용 유무를 설정한 제스쳐입니다.
  Future<void> setGesture(GestureType gesture, bool enable);

  /// 캐시 데이터를 지웁니다.
  Future<void> clearCache();

  /// 디스크에 저장된 캐시 데이터를 지웁니다.
  Future<void> clearDiskCache();

  /// 주어진 [zoomLevel]과 [position]에 담긴 위/경도 배열이 카메라 모두 담을 수 있는지 확인합니다.
  /// 확인된 결과는 [bool] 형태로 반환받으며, 모두 스크린에 표현할 수 있을 경우 [True]를 반환합니다.
  Future<bool> canShowPosition(int zoomLevel, List<LatLng> position);

  /// 지도 형태를 변경합니다.
  Future<void> changeMapType(MapType mapType);
}
