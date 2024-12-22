part of '../flutter_kakao_map.dart';

class KakaoMap extends StatefulWidget {
  final KakaoMapOption? option;

  final void Function(KakaoMapController controller) onMapReady;
  final KakaoMapLifecycle? onMapLifecycle;
  final void Function(Exception exception)? onMapError;
  final void Function(GestureType gestureType)? onCameraMoveStartHandler;
  final void Function(CameraPosition position, GestureType gestureType)? onCameraMoveEndHandler;

  final bool forceGesture;

  const KakaoMap(
      {super.key,
      required this.onMapReady,
      this.option,
      this.forceGesture = true,
      this.onMapLifecycle,
      this.onCameraMoveStartHandler,
      this.onCameraMoveEndHandler,
      this.onMapError
    });

  @override
  State<StatefulWidget> createState() => _KakaoMapState();
}

class _KakaoMapState extends State<KakaoMap> with KakaoMapControllerHandler {
  // ignore: constant_identifier_names
  static const VIEW_TYPE = "plugin/kakao_map";
  late final MethodChannel channel;
  late final KakaoMapController controller;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> rawParams = widget.option?.toMessageable() ??
        (const KakaoMapOption()).toMessageable();

    // GestureRecognizer
    final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {};
    if (widget.forceGesture) {
      gestureRecognizers
          .add(Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer()));
    }

    return _createPlatformView(
        viewType: VIEW_TYPE,
        gestureRecognizers: gestureRecognizers,
        onPlatformViewCreated: onPlatformViewCreated,
        creationParams: rawParams);
  }

  void onPlatformViewCreated(int viewId) {
    channel = ChannelType.view.channelWithId(viewId);
    channel.setMethodCallHandler(handle);
    controller = KakaoMapController(channel);
  }

  /* Handler */
  @override
  void onMapDestroy() {
    widget.onMapLifecycle?.onMapDestroy?.call();
  }

  @override
  void onMapResumed() {
    widget.onMapLifecycle?.onMapResumed?.call();
  }

  @override
  void onMapPaused() {
    widget.onMapLifecycle?.onMapPaused?.call();
  }

  @override
  void onMapError(Exception exception) {
    widget.onMapError?.call(exception);
  }

  @override
  void onMapReady() {
    widget.onMapReady.call(controller);
  }

  @override
  void onCameraMoveStart(GestureType gestureType) {
    widget.onCameraMoveStartHandler?.call(gestureType);
  }

  @override
  void onCameraMoveEnd(CameraPosition position, GestureType gestureType) {
    widget.onCameraMoveEndHandler?.call(position, gestureType);
  }
}
