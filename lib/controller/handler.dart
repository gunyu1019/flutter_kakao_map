part of '../flutter_kakao_map.dart';


mixin KakaoMapControllerHandler {
  Future<dynamic> handle(MethodCall method) async {
    switch(method.method) {
      case "onMapReady": 
        onMapReady();
        break;
      case "onMapDestroy": 
        onMapDestroy();
        break;
      case "onMapPaused": 
        onMapPaused();
        break;
      case "onMapResumed": 
        onMapResumed();
        break;
      case "onMapError": 
        onMapError(method.arguments);
        break;
      default:
        break;
    }
  }

  void onMapReady();

  void onMapDestroy();

  void onMapResumed();

  void onMapPaused();
  
  void onMapError(dynamic exception);
}