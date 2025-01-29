part of '../../flutter_kakao_maps.dart';

class Poi {
  final LabelController _controller;
  final String id;

  final TransformMethod? transform;

  LatLng _position;
  LatLng get position => _position;

  void Function()? _onClick;
  bool get clickable => _onClick != null;

  String? _text;
  String? get text => _text;

  int _rank;
  int get rank => _rank;

  PoiStyle _style;
  PoiStyle get style => _style;

  bool _visible;
  bool get visible => _visible;

  Poi._(this._controller, this.id,
      {required this.transform,
      required LatLng position,
      required bool clickable,
      required PoiStyle style,
      required String? text,
      required int rank,
      required bool visible,
      void Function()? onClick})
      : _position = position,
        _onClick = onClick,
        _style = style,
        _text = text,
        _rank = rank,
        _visible = visible;

  // void addBadge();

  void addSharePosition(Poi poi) {

  }

  void addShareTransform(Poi poi) {

  }

  Future<void> changeOffsetPosition(double x, double y, [bool forceDpScale = false]) async {
    final prePosition = _position;
    _position = LatLng(prePosition.latitude + x, prePosition.longitude + y);
    await _controller._changePoiOffsetPosition(id, x, y, forceDpScale);
  }

  Future<void> changeRank(int rank) async {
    _rank = rank;
    await _controller._rankPoi(id, rank);
  }

  Future<void> changeStyles(PoiStyle style, [bool transition = false]) async {
    final styleId = style.id ?? await _controller.manager.addPoiStyle(style);
    await _controller._changePoiStyle(id, styleId);
    _style = style;
  } 

  Future<void> changeText(String text, [bool transition = false]) async {
    _text = text;
    await _controller._changePoiText(id, text);
  }

  Future<void> hide() async {
    _visible = false;
    await _controller._changePoiVisible(id, false);
  }

  Future<void> invalidate([bool transition = false]) async {
    final styleId = style.id ?? await _controller.manager.addPoiStyle(style);
    await _controller._invalidatePoi(id, styleId, text, transition);
  }

  Future<void> move(LatLng position, [double? millis]) async {
    _position = position;
    await _controller._movePoi(id, position, millis);
  }

  Future<void> remove() async {
    await _controller.removePoi(this);
  }

  // void removeBadge();

  // void removeAllBadge();

  void removeSharePosition(Poi poi) {

  }

  void removeShareTransform(Poi poi) {

  }

  Future<void> rotate(double angle, [double? millis]) async {
    await _controller._rotatePoi(id, angle, millis);
  }

  Future<void> scale(double x, double y, [double? millis]) async {
    await _controller._scalePoi(id, x, y, millis);
  }

  void setStyle(PoiStyle style) async {
    _style = style;
  }

  void setText() {
    _text = text;
  }

  Future<void> show([bool? autoMove, double? duration]) async {
    _visible = true;
    await _controller._changePoiVisible(id, true);
  }
}
