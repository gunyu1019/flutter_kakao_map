part of '../../flutter_kakao_map.dart';


class LodPoi {
  final LodLabelController _controller;
  final String id;

  final TransformMethod? transform;
  final LatLng position;

  void Function()? _onClick;
  bool get clickable => _onClick != null;

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

  LodPoi._(this._controller, this.id,
      {required this.transform,
      required this.position,
      required bool clickable,
      required String styleId,
      required List<PoiStyle> styles,
      required String? text,
      required int rank,
      required bool visible,
      void Function()? onClick})
      : _onClick = onClick,
        _styleId = styleId,
        _styles = styles,
        _text = text,
        _rank = rank,
        _visible = visible;

  Future<void> changeRank(int rank) async {
    _rank = rank;
    await _controller._rankPoi(id, rank);
  }

  Future<void> changeStyles(String? styleId, List<PoiStyle>? styles, [bool transition = false]) async {
    _styleId = await _controller.manager._validatePoiStyle(styles, styleId);
    _styles = _controller.manager._poiStyle[_styleId]!;
    await _controller._changePoiStyle(id, _styleId);
  }
  
  Future<void> changeText(String text) async {
    _styles = styles;
    _text = text;
    await _controller._changePoiText(id, text);
  }

  Future<void> remove() async {
    await _controller.removeLodPoi(this);
  }

  Future<void> hide() async {
    await _controller._changePoiVisible(id, false);
    _visible = false;
  }

  Future<void> show() async {
    await _controller._changePoiVisible(id, true);
    _visible = true;
  }
}