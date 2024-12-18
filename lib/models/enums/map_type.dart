part of '../../flutter_kakao_map.dart';

enum MapType {
  normal(value: "map"),
  skyview(value: "skyview");
  
  final String value;
  
  const MapType({required this.value});
}