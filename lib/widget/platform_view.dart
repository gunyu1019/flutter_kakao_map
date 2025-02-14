part of '../kakao_map_sdk.dart';

StatefulWidget _createPlatformView({
  required String viewType,
  required Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers,
  Function(int)? onPlatformViewCreated,
  Map<String, dynamic> creationParams = const {},
  MessageCodec creationParamsCodec = const StandardMessageCodec(),
}) {
  if (Platform.isAndroid) {
    return PlatformViewLink(
        surfaceFactory: (context, controller) => AndroidViewSurface(
            controller: controller as AndroidViewController,
            hitTestBehavior: PlatformViewHitTestBehavior.opaque,
            gestureRecognizers: gestureRecognizers),
        onCreatePlatformView: (params) {
          return PlatformViewsService.initSurfaceAndroidView(
            id: params.id,
            viewType: viewType,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: creationParamsCodec,
            onFocus: () {
              params.onFocusChanged(true);
            },
          )
            ..addOnPlatformViewCreatedListener((viewId) {
              params.onPlatformViewCreated(viewId);
              onPlatformViewCreated?.call(viewId);
            })
            ..create();
        },
        viewType: viewType);
  } else if (Platform.isIOS) {
    return UiKitView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
      onPlatformViewCreated: onPlatformViewCreated,
    );
  } else {
    throw PlatformException(code: "unsupportedPlatform");
  }
}
