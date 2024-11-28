part of '../flutter_kakao_map.dart';

class KakaoMap extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _KakaoMapState();
  }
}

class _KakaoMapState extends State<KakaoMap> {
  @override
  Widget build(BuildContext context) {
    const VIEW_TYPE = "plugin/kakao_map";
    if (Platform.isAndroid) {
      return PlatformViewLink(
          surfaceFactory: (context, controller) {
            return AndroidViewSurface(
                controller: controller as AndroidViewController,
                hitTestBehavior: PlatformViewHitTestBehavior.opaque,
                gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{}
            );
          }, onCreatePlatformView: (params) {
            return PlatformViewsService.initSurfaceAndroidView(
                id: params.id,
                viewType: VIEW_TYPE,
                layoutDirection: TextDirection.ltr
            )
            ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
            ..create();
      }, viewType: VIEW_TYPE);
    } else if (Platform.isIOS) {
      // TODO
      throw UnimplementedError("TODO");
    } else {
      throw PlatformException(code: "unsupportedPlatform");
    }
  }
}