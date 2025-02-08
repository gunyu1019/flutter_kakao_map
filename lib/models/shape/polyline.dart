part of '../../flutter_kakaomaps.dart';

class Polyline<T extends BasePoint> {
  final ShapeController _controller;
  final String id;

  PolylineStyle _style;
  PolylineStyle get style => _style;

  T _position;
  T get position => _position;

  bool _visible;
  bool get visible => _visible;

  PolylineCap _polylineCap;
  PolylineCap get polylineCap => _polylineCap;

  Polyline._(ShapeController controller, this.id,
      {required T position, required PolylineStyle style, required PolylineCap polylineCap})
      : _controller = controller,
        _style = style,
        _position = position,
        _polylineCap = polylineCap,
        _visible = true;

  Future<void> changeStyle(PolylineStyle style, PolylineCap? polylineCap) async {
    _polylineCap = polylineCap ?? _polylineCap;
    final styleId = style.id ?? await _controller.manager.addPolylineShapeStyle(style, _polylineCap);
    await _controller._changePolylineStyle(id, styleId);
    _style = style;
  }

  Future<void> changePosition(T position) async {
    await _controller._changePolylinePosition(id, position);
    _position = position;
  }

  Future<void> show() async {
    await _controller._changePolylineVisible(id, true);
    _visible = true;
  }

  Future<void> hide() async {
    await _controller._changePolylineVisible(id, false);
    _visible = false;
  }
}
