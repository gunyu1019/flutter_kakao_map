import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_kakao_map_method_channel.dart';

abstract class FlutterKakaoMapPlatform extends PlatformInterface {
  /// Constructs a FlutterKakaoMapPlatform.
  FlutterKakaoMapPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterKakaoMapPlatform _instance = MethodChannelFlutterKakaoMap();

  /// The default instance of [FlutterKakaoMapPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterKakaoMap].
  static FlutterKakaoMapPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterKakaoMapPlatform] when
  /// they register themselves.
  static set instance(FlutterKakaoMapPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
