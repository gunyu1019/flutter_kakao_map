part of '../../flutter_kakaomaps.dart';

enum MapType {
  normal(value: "map"),
  skyview(value: "skyview");
  
  final String value;
  
  const MapType({required this.value});
}