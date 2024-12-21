part of '../../flutter_kakao_map.dart';


mixin KakaoMapEventControllerHandler {
  Future<dynamic> handle(MethodCall method) async {
    switch(method.method) {
      case "onCameraMoveStart":
        final arguments = method.arguments;
        final gesture = GestureType.values.firstWhere(
          (el) => arguments['gesture'] as int == el.value,
          orElse: () => GestureType.unknown
        );
        onCameraMoveStart(gesture);
        break;
      case "onCameraMoveEnd":
        final arguments = method.arguments;
        final position = CameraPosition.fromMessageable(arguments['position']);
        final gesture = GestureType.values.firstWhere(
          (el) => arguments['gesture'] as int == el.value,
          orElse: () => GestureType.unknown
        );
        onCameraMoveEnd(position, gesture);
        break;
      default:
        break;
    }
  }

  void onCameraMoveStart(GestureType gestureType);

  void onCameraMoveEnd(CameraPosition position,GestureType gestureType);
}