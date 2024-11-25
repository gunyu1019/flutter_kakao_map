import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_kakao_map_platform_interface.dart';

/// An implementation of [FlutterKakaoMapPlatform] that uses method channels.
class MethodChannelFlutterKakaoMap extends FlutterKakaoMapPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_kakao_map');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
