part of '../../flutter_kakao_maps.dart';

enum EventType {
  onCameraMoveStart(1),
  onCameraMoveEnd(2),
  onCompassClick(4),
  onMapClick(8),
  onTerrainClick(16),
  onTerrainLongClick(32);

  final int id;

  const EventType(this.id);
}