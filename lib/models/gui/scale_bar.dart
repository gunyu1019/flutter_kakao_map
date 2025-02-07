part of '../../flutter_kakao_maps.dart';

class ScaleBar extends DefaultGUI {
  @override
  DefaultGUIType get type => DefaultGUIType.scale;

  @override
  KakaoMapControllerSender _controller;

  ScaleBar._({
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

  Future<void> setAnimationTime(int fadeIn, int fadeOut, int retention) async {
    await _controller._scaleAnimationTime(fadeIn, fadeOut, retention);
  }

  Future<void> setAutohide(bool autohide) async {
    await _controller._scaleAutohide(autohide);
  }
}
