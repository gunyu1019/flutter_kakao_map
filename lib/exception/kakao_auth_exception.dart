part of '../flutter_kakao_map.dart';

class KakaoAuthException implements Exception {
  final int code;
  final String? message;

  KakaoAuthException(this.code, this.message);

  KakaoAuthException.fromMessageable(dynamic payload)
      : this(payload['errorCode']!, payload['message']);

  @override
  String toString() => "KakaoAuthException(code: $code, message: $message)";
}
