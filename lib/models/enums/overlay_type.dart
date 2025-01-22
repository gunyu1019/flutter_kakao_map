part of '../../flutter_kakao_map.dart';

enum OverlayType {
  label(value: 1),
  lodLabel(value: 2),
  shape(value: 3);

  final int value;  

  const OverlayType({required this.value});
}