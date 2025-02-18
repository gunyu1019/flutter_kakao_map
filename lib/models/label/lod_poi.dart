part of '../../kakao_map_sdk.dart';

class LodPoi {
  final LodLabelController _controller;
  final String id;

  final TransformMethod? transform;
  final LatLng position;

  void Function()? onClick;
  bool get clickable => onClick != null;

  String? _text;
  String? get text => _text;

  int _rank;
  int get rank => _rank;

  PoiStyle _style;
  PoiStyle get styles => _style;

  bool _visible;
  bool get visible => _visible;

  LodPoi._(this._controller, this.id,
      {required this.transform,
      required this.position,
      required PoiStyle style,
      required String? text,
      required int rank,
      required bool visible,
      this.onClick})
      : _style = style,
        _text = text,
        _rank = rank,
        _visible = visible;

  Future<void> changeRank(int rank) async {
    _rank = rank;
    await _controller._rankPoi(id, rank);
  }

  Future<void> changeStyle(PoiStyle style, [bool transition = false]) async {
    final styleId = style.id ?? await _controller.manager.addPoiStyle(style);
    await _controller._changePoiStyle(id, styleId);
    _style = style;
  }

  Future<void> changeText(String text, [bool transition = false]) async {
    _text = text;
    await _controller._changePoiText(id, text, _style.id!, transition);
  }

  Future<void> remove() async {
    await _controller.removeLodPoi(this);
  }

  Future<void> hide() async {
    await _controller._changePoiVisible(id, false);
    _visible = false;
  }

  Future<void> show([bool? autoMove, int? duration]) async {
    await _controller._changePoiVisible(id, true,
        autoMove: autoMove, duration: duration);
    _visible = true;
  }
}
