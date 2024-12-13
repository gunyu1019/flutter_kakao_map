part of '../flutter_kakao_map.dart';

abstract class KakaoMapSdk {
  static final instance = KakaoMapSdkImplement();

  Future<void> initialize(String token);

  Future<String> hashKey();
}