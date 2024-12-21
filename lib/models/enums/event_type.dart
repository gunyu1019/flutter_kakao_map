part of '../../flutter_kakao_map.dart';

enum EventType {
  onCameraMoveStart("camera_move_start"),
  onCameraMoveEnd("camera_move_end");

  final String id;

  const EventType(this.id);
}