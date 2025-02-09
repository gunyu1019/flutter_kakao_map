part of '../../kakao_map_sdk.dart';

enum DefaultGUIType {
  compass(value: "compass"),
  scale(value: "scale"),
  logo(value: "logo");

  final String value;

  const DefaultGUIType({required this.value});
}
