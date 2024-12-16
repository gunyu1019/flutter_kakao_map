part of '../flutter_kakao_map.dart';

class KakaoAuthException implements Exception {
  final String code;
  final String? message;

  KakaoAuthException(this.code, this.message);

  KakaoAuthException.fromMessageable(Map<String, dynamic> payload)
      : this(payload['errorCode']!, payload['message']);

  @override
  String toString() => "KakaoAuthException(code: $code, message: $message)";
}
