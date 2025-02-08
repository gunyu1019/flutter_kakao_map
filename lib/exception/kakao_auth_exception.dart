part of '../kakao_map.dart';

/// 카카오 인증에 실패하면 호출되는 예외 객체입니다.
class KakaoAuthException implements Exception {
  final int code;
  final String? message;

  KakaoAuthException(this.code, this.message);

  factory KakaoAuthException.fromMessageable(dynamic payload) =>
      KakaoAuthException(payload['errorCode']!, payload['message']);

  @override
  String toString() => "KakaoAuthException(code: $code, message: $message)";
}
