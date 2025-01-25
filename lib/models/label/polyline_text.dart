part of '../../flutter_kakao_map.dart';


class PolylineText {
  final LabelController _controller;
  final String id;
  final List<LatLng> points;

  PolylineTextStyle _style;
  PolylineTextStyle get style => _style;

  String _text;
  String get text => _text;

  bool _visible;
  bool get visible => _visible;

  PolylineText._(this._controller, this.id, {
    required PolylineTextStyle style,
    required String text,
    required this.points,
    bool visible = true
  }) : _style = style, _text = text, _visible = visible;

  Future<void> changeStyles(PolylineTextStyle style) async {
    _style = style;
    await _controller._changePolylineTextStyle(id, style);
  }
  
  Future<void> changeTextAndStyles(String text, PolylineTextStyle style) async {
    _style = style;
    _text = text;
    await _controller._changePolylineTextStyle(id, style, text);
  }
  
  Future<void> changeText(String text) async {
    _text = text;
    await _controller._changePolylineTextStyle(id, _style, text);
  }

  Future<void> remove() async {
    await _controller.removePolylineText(this);
  }

  Future<void> hide() async {
    await _controller._changePolylineTextVisible(id, false);
    _visible = false;
  }

  Future<void> show() async {
    await _controller._changePolylineTextVisible(id, true);
    _visible = true;
  }
}