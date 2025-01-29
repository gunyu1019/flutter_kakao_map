part of '../../flutter_kakao_maps.dart';

enum EventType {
  onCameraMoveStart(1),
  onCameraMoveEnd(2);

  final int id;

  const EventType(this.id);
}