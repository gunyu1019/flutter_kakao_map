part of '../flutter_kakao_map.dart';

class KakaoMap extends StatefulWidget {
  const KakaoMap({super.key});

  @override
  State<StatefulWidget> createState() {
    return _KakaoMapState();
  }
}

class _KakaoMapState extends State<KakaoMap> {
  static const VIEW_TYPE = "plugin/kakao_map";
  late final MethodChannel channel;

  @override
  Widget build(BuildContext context) {

    if (Platform.isAndroid) {
      Map<String, dynamic> creationParams = <String, dynamic>{};
      return PlatformViewLink(
          surfaceFactory: (context, controller) {
            return AndroidViewSurface(
                controller: controller as AndroidViewController,
                hitTestBehavior: PlatformViewHitTestBehavior.opaque,
                gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{});
          },
          onCreatePlatformView: (params) {
            return PlatformViewsService.initSurfaceAndroidView(
              id: params.id,
              viewType: VIEW_TYPE,
              layoutDirection: TextDirection.ltr,
              creationParams: creationParams,
              creationParamsCodec: const StandardMessageCodec(),
              onFocus: () {
                params.onFocusChanged(true);
              },
            )
              ..addOnPlatformViewCreatedListener((viewId) {
                params.onPlatformViewCreated(viewId);

                channel = MethodChannel("flutter_kakao_map_view#${viewId}");
                // channel.invokeMethod("hashCode");
                channel.invokeMethod("start");
              })
              ..create();
          },
          viewType: VIEW_TYPE);
    } else if (Platform.isIOS) {
      // TODO
      throw UnimplementedError("TODO");
    } else {
      throw PlatformException(code: "unsupportedPlatform");
    }
  }
}
