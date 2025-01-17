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
  }
  
  Future<void> changeTextAndStyles(String text, List<PolylineTextStyle> styles) async {
    _styles = styles;
    _text = text;
  }

  Future<void> remove() async {

  }

  Future<void> hide() async {
    _visible = false;
  }

  Future<void> show() async {
    _visible = true;
  }
}