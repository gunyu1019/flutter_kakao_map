part of '../../flutter_kakao_map.dart';


class KakaoMapEventController with KakaoMapEventControllerHandler, KakaoMapEventControllerSender {
  final MethodChannel channel;

  void Function(GestureType gestureType)? onCameraMoveStartHandler;
  void Function(CameraPosition position, GestureType gestureType)? onCameraMoveEndHandler;

  KakaoMapEventController(this.channel) {
    channel.setMethodCallHandler(handle);
  }

  @override
  Future<void> setEventHandler(
    EventType type,
    bool enable
  ) async {
    await channel.invokeMethod("setEventHandler", {
      "event": type.id,
      "enable": enable
    });
  }
  
  @override
  void onCameraMoveStart(GestureType gestureType) {
    onCameraMoveStartHandler?.call(gestureType);
  }

  @override
  void onCameraMoveEnd(CameraPosition position, GestureType gestureType) {
    onCameraMoveEndHandler?.call(position, gestureType);
  }
}