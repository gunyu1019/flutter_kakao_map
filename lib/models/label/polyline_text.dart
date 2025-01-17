part of '../../flutter_kakao_map.dart';


class PolylineText {
  final LabelController _controller;
  final String id;
  final List<LatLng> points;

  List<PolylineTextStyle> _styles;
  List<PolylineTextStyle> get styles => _styles;

  String _text;
  String get text => _text;

  bool _visible;
  bool get visible => _visible;

  PolylineText._(this._controller, this.id, {
    required List<PolylineTextStyle> styles,
    required String text,
    required this.points,
    bool visible = true
  }) : _styles = styles, _text = text, _visible = visible;

  Future<void> changeStyles(List<PolylineTextStyle> styles) async {
    _styles = styles;
    await _controller._changePolylineTextStyle(id, styles);
  }
  
  Future<void> changeTextAndStyles(String text, List<PolylineTextStyle> styles) async {
    _styles = styles;
    _text = text;
    await _controller._changePolylineTextStyle(id, styles, text);
  }

  Future<void> remove() async {
    await _controller.removePolylineText(this);
  }

  Future<void> hide() async {
    await _controller._changePolylineText(id, false);
    _visible = false;
  }

  Future<void> show() async {
    await _controller._changePolylineText(id, true);
    _visible = true;
  }
}