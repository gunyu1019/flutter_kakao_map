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
        onMapError(method.arguments['exception']);
        break;
      default:
        break;
    }
  }

  void onMapReady();

  void onMapDestroy();
  
  void onMapError(Map<String, dynamic> exception);
}