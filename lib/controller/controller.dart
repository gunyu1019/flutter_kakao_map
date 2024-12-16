part of '../flutter_kakao_map.dart';

class KakaoMapController with KakaoMapControllerHandler {
  final MethodChannel channel;
  final KakaoMap widget;

  KakaoMapController(this.channel, this.widget) {
    channel.setMethodCallHandler(handle);
  }
  
  @override
  void onMapDestroy() {
    widget.onMapDestroy?.call();
  }
  
  @override
  void onMapError(Map<String, dynamic> exception) {
    final String className = exception['className'];
    switch (className) {
      case 'MapAuthException':
        widget.onMapError?.call(
          KakaoAuthException.fromMessageable(exception)
        );
        break;
      default:
        widget.onMapError?.call(
          Exception("${exception['className']}(${exception['message']})")
        );
        break;
    }
    
  }
  
  @override
  void onMapReady() {
    widget.onMapReady.call(this);
  }
}