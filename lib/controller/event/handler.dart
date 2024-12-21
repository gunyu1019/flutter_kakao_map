part of '../../flutter_kakao_map.dart';


mixin KakaoMapEventControllerHandler {
  Future<dynamic> handle(MethodCall method) async {
    switch(method.method) {
      case "onCameraMoveStart":
      case "onCameraMoveEnd":
      default:
        break;
    }
  }

  void onCameraMoveStart(GestureType gestureType);

  void onCameraMoveEnd(CameraPosition position,GestureType gestureType);
}