part of '../flutter_kakaomaps.dart';

abstract class KakaoMapSdk {
  static final instance = KakaoMapSdkImplement();

  /// 애플리케이션을 주어진 [appKey]를 통해 인증합니다.
  /// [appKey]에 입력되는 키는 카카오 개발자센터에 사전에 등록된 네이티브 키입니다.
  Future<void> initialize(String appKey);

  /// [initialize] 함수를 통해 인증을 했는지 확인하는 함수입니다.
  Future<bool> isInitialize();

  /// 애플리케이션의 Base64로 인코딩된 키 해시를 가져옵니다. 
  /// 키 해시는 애플리케이션을 인증하는 용도로 사용됩니다. 안드로이드 전용 기능입니다.
  /// 안드로이드 전용 기능이며, 다른 플랫폼에서는 null을 반환합니다.
  Future<String?> hashKey();
}