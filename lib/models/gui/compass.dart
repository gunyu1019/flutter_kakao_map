part of '../../flutter_kakao_maps.dart';

class Compass extends DefaultGUI {
  @override
  DefaultGUIType get type => DefaultGUIType.compass;

  @override
  KakaoMapControllerSender _controller;

  Compass._({
    required KakaoMapControllerSender controller,
  }) : _controller = controller;

  Future<void> hide() async {
    await _controller._defaultGUIvisible(type, false);
  }

  Future<void> show() async {
    await _controller._defaultGUIvisible(type, true);
  }

  Future<void> changePosition(MapGravity gravity, double x, double y) async {
    await _controller._defaultGUIposition(type, gravity, x, y);
  }
}
