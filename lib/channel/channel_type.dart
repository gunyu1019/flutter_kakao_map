part of '../flutter_kakao_map.dart';

enum ChannelType {
  sdk("${_baseChannelId}_sdk"),
  event("${_baseChannelId}_event"),
  view("${_baseChannelId}_view");

  final String id;
  
  MethodChannel get channel => MethodChannel(id);
  MethodChannel channelWithId(int id) => MethodChannel("${this.id}#$id");

  const ChannelType(this.id);

  static const String _baseChannelId = "flutter_kakao_map";
}