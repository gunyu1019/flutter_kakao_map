part of '../../flutter_kakaomaps.dart';

enum OverlayType {
  label(value: 1),
  lodLabel(value: 2),
  shape(value: 3),
  route(value: 4);

  final int value;  

  const OverlayType({required this.value});
}