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
      case "onMapError": 
        onMapError(method.arguments);
        break;
      default:
        break;
    }
  }

  void onMapReady();

  void onMapDestroy();
  
  void onMapError(dynamic exception);
}