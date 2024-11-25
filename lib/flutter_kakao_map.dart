
import 'flutter_kakao_map_platform_interface.dart';

class FlutterKakaoMap {
  Future<String?> getPlatformVersion() {
    return FlutterKakaoMapPlatform.instance.getPlatformVersion();
  }
}
