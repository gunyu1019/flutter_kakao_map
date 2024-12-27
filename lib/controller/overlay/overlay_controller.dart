part of '../../flutter_kakao_map.dart';

abstract class OverlayController {
  abstract final MethodChannel channel;
  abstract final OverlayType type;

  Future<T> _invokeMethod<T>(String method, Map<String, dynamic> payload) async {
    payload['type'] = type.value;
    return await channel.invokeMethod(method, payload);
  }
}