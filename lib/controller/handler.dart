part of '../flutter_kakao_map.dart';


mixin KakaoMapControllerHandler {
  Future<dynamic> handle(MethodCall method) async {
    switch(method.method) {
      case "onMapReady": 
        onMapReady();
        break;
      case "onMapDestroyed": 
        onMapDestroyed();
        break;
      case "onMapError": 
        onMapError(method.arguments['exception']);
        break;
    }
  }

  void onMapReady();

  void onMapDestroyed();
  
  void onMapError(Map<String, dynamic> exception);
}