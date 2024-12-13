part of '../flutter_kakao_map.dart';

class ChannelWrapper {
  final MethodChannel _channel;

  Future<T?> invoke<T>(String method, [dynamic arguments]) {
    return _channel.invokeMethod(method, arguments);
  }

  void setHandler(Future<dynamic> Function(MethodCall)? handler) {
    _channel.setMethodCallHandler(handler);
  }

  void dispose() {
    _channel.setMethodCallHandler(null);
  }

  const ChannelWrapper(this._channel);

  ChannelWrapper.withId(String id) : this(MethodChannel(id));
}