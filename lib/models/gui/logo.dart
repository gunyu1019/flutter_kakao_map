part of '../../flutter_kakao_maps.dart';

class Logo extends DefaultGUI {
  @override
  DefaultGUIType get type => DefaultGUIType.logo;

  @override
  KakaoMapControllerSender _controller;

  Logo._({
    required KakaoMapControllerSender controller,
  }) : _controller = controller;

  Future<void> changePosition(MapGravity gravity, double x, double y) async {
    await _controller._defaultGUIposition(type, gravity, x, y);
  }
}
