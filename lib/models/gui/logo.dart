part of '../../kakao_map.dart';

class Logo extends DefaultGUI {
  @override
  DefaultGUIType get type => DefaultGUIType.logo;

  KakaoMapControllerSender _controller;

  Logo._({
    required KakaoMapControllerSender controller,
  }) : _controller = controller;

  /// 지도에 표시된 나침판의 위치를 조정합니다.
  Future<void> changePosition(MapGravity gravity, double x, double y) async {
    await _controller._defaultGUIposition(type, gravity, x, y);
  }
}
