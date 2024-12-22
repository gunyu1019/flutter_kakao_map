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
        final String className = method.arguments['className'];
        switch (className) {
          case 'MapAuthException':
            onMapError(KakaoAuthException.fromMessageable(method.arguments));
            break;
          default:
            onMapError(Exception("${method.arguments['className']}(${method.arguments['message']})"));
            break;
        }
        break;
      default:
        break;
    }
  }

  void onMapReady();

  void onMapDestroy();

  void onMapResumed();

  void onMapPaused();
  
  void onMapError(Exception exception);
}