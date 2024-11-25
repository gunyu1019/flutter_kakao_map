import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_kakao_map/flutter_kakao_map.dart';
import 'package:flutter_kakao_map/flutter_kakao_map_platform_interface.dart';
import 'package:flutter_kakao_map/flutter_kakao_map_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterKakaoMapPlatform
    with MockPlatformInterfaceMixin
    implements FlutterKakaoMapPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterKakaoMapPlatform initialPlatform = FlutterKakaoMapPlatform.instance;

  test('$MethodChannelFlutterKakaoMap is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterKakaoMap>());
  });

  test('getPlatformVersion', () async {
    FlutterKakaoMap flutterKakaoMapPlugin = FlutterKakaoMap();
    MockFlutterKakaoMapPlatform fakePlatform = MockFlutterKakaoMapPlatform();
    FlutterKakaoMapPlatform.instance = fakePlatform;

    expect(await flutterKakaoMapPlugin.getPlatformVersion(), '42');
  });
}
