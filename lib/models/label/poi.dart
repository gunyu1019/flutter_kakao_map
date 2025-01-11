part of '../../flutter_kakao_map.dart';

class Poi {
  final LabelController _controller;
  final String id;

  final TransformMethod? transform;

  LatLng _position;
  LatLng get position => _position;

  bool _clickable;
  bool get clickable => _clickable;

  String? _text;
  String? get text => _text;

  int _rank;
  int get rank => _rank;

  String _styleId;
  String get styleId => _styleId;

  List<PoiStyle> _styles;
  List<PoiStyle> get styles => _styles;

  bool _visible;
  bool get visible => _visible;

  Poi._(this._controller, this.id,
      {required this.transform,
      required LatLng position,
      required bool clickable,
      required String styleId,
      required List<PoiStyle> styles,
      required String? text,
      required int rank,
      required bool visible})
      : _position = position,
        _clickable = clickable,
        _styleId = styleId,
        _styles = styles,
        _text = text,
        _rank = rank,
        _visible = visible;

  // void addBadge();

  void addSharePosition(Poi poi) {

  }

  void addShareTransform​(Poi poi) {

  }

  Future<void> changeOffsetPosition(double x, double y, [bool forceDpScale = false]) async {
    final prePosition = _position;
    _position = LatLng(prePosition.latitude + x, prePosition.longitude + y);
    _controller._changePoiOffsetPosition(id, x, y, forceDpScale);
  }

  void changeRank(int rank) {
    _rank = rank;
  }

  void changeStyles(String? styleId, List<PoiStyle> styles) {

  } 

  void changeText(String text) {
    _text = text;
  }

  Future<void> hide() async {
    _visible = false;
    await _controller._changePoiVisible(id, false);
  }

  void invalidate([bool enableTransition = false]) {

  }

  void moveTo(LatLng position, [double? milis]) {
    _position = position;
  }

  void remove() {

  }

  // void removeBadge();

  // void removeAllBadge();

  void removeSharePosition(Poi poi) {

  }

  void removeShareTransform(Poi poi) {

  }

  void setClickable(bool clickable) {
    _clickable = clickable;
  }

  void setRank(int rank) {
    _rank = rank;
  }

  void scaleTo(double x, double y, [double? milis]) {
    
  }

  Future<void> show() async {
    _visible = true;
    await _controller._changePoiVisible(id, true);
  }
}
