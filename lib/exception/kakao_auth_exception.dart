part of '../flutter_kakao_maps.dart';

class KakaoAuthException implements Exception {
  final int code;
  final String? message;

  KakaoAuthException(this.code, this.message);

  factory KakaoAuthException.fromMessageable(dynamic payload)
      => KakaoAuthException(payload['errorCode']!, payload['message']);

  @override
  String toString() => "KakaoAuthException(code: $code, message: $message)";
}
