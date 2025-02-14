part of '../kakao_map_sdk.dart';

enum ChannelType {
  sdk("${_baseChannelId}_sdk"),
  overlay("${_baseChannelId}_overlay"),
  view("${_baseChannelId}_view");

  final String id;

  MethodChannel get channel => MethodChannel(id);
  MethodChannel channelWithId(int id) => MethodChannel("${this.id}#$id");

  const ChannelType(this.id);

  static const String _baseChannelId = "flutter_kakao_maps";
}
