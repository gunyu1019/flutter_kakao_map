part of '../../flutter_kakaomaps.dart';


class MapPoint extends BasePoint {
  final List<LatLng> points;
  final List<List<LatLng>> _holes = [];

  MapPoint(this.points);

  void addHole(List<LatLng> hole) => _holes.add(hole);

  int get holeCount => _holes.length;

  List<LatLng>? getHole(int index) => _holes[index];

  void removeHole(int index) => _holes.removeAt(index);

  @override
  Map<String, dynamic> toMessageable() {
    return <String, dynamic>{
      "type": type,  // point type
      "points": points.map((e) => e.toMessageable()).toList(),
      "holes": _holes.map((e1) => e1.map((e2) => e2.toMessageable()).toList()).toList()
    };
  }
  
  @override
  int get type => 0;
}