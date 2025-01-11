part of '../../flutter_kakao_map.dart';

class Poi {
  final LabelController _controller;
  final String? id;

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
}
