part of '../../flutter_kakao_map.dart';

enum DefaultGUIType {
  compass(value: "compass"),
  scale(value: "scale"),
  logo(value: "logo");

  final String value;  

  const DefaultGUIType({required this.value});
}