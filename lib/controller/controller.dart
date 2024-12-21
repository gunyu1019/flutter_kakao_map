part of '../flutter_kakao_map.dart';

class KakaoMapController
    with KakaoMapControllerHandler, KakaoMapControllerSender {
  final MethodChannel channel;
  final KakaoMap widget;

  KakaoMapController(this.channel, this.widget) {
    channel.setMethodCallHandler(handle);
  }

  /* Sender */
  @override
  Future<CameraPosition> getCameraPosition() async {
    final rawCameraPosition = await channel.invokeMethod("getCameraPosition");
    return CameraPosition.fromMessageable(rawCameraPosition);
  }

  @override
  Future<void> moveCamera(CameraUpdate camera,
      {CameraAnimation? animation}) async {
    await channel.invokeMethod("moveCamera", {
      "cameraUpdate": camera.toMessageable(),
      "cameraAnimation": animation?.toMessageable()
    });
  }

  @override
  Future<void> setGestureEnable(GestureType gestrueType, bool enable) async {
    await channel.invokeMethod('setGestureEnable', {
      "gestureType": gestrueType.value,
      "enable": enable
    });
  }

  /* Handler */
  @override
  void onMapDestroy() {
    widget.onMapLifecycle?.onMapDestroy?.call();
  }

  @override
  void onMapResumed() {
    widget.onMapLifecycle?.onMapResumed?.call();
  }

  @override
  void onMapPaused() {
    widget.onMapLifecycle?.onMapPaused?.call();
  }

  @override
  void onMapError(dynamic exception) {
    final String className = exception['className'];
    switch (className) {
      case 'MapAuthException':
        widget.onMapError?.call(KakaoAuthException.fromMessageable(exception));
        break;
      default:
        widget.onMapError?.call(
            Exception("${exception['className']}(${exception['message']})"));
        break;
    }
  }

  @override
  void onMapReady() {
    widget.onMapReady.call(this);
  }
}
