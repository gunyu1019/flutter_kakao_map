part of '../flutter_kakao_maps.dart';

class KakaoMap extends StatefulWidget {
  final KakaoMapOption? option;

  final void Function(KakaoMapController controller) onMapReady;
  final KakaoMapLifecycle? onMapLifecycle;
  final void Function(Exception exception)? onMapError;
  final void Function(GestureType gestureType)? onCameraMoveStart;
  final void Function(CameraPosition position, GestureType gestureType)?
      onCameraMoveEnd;

  final void Function()? onCompassClick;
  final void Function(LabelController labelController, Poi poi)? onPoiClick;
  final void Function(LodLabelController lodLabelController, LodPoi poi)?
      onLodPoiClick;
  final void Function(KPoint point, LatLng position)? onMapClick;
  final void Function(KPoint point, LatLng position)? onTerrainClick;
  final void Function(KPoint point, LatLng position)? onTerrainLongClick;

  final bool forceGesture;

  const KakaoMap(
      {super.key,
      required this.onMapReady,
      this.option,
      this.forceGesture = true,
      this.onMapLifecycle,
      this.onCameraMoveStart,
      this.onCameraMoveEnd,
      this.onCompassClick,
      this.onPoiClick,
      this.onLodPoiClick,
      this.onMapClick,
      this.onTerrainClick,
      this.onTerrainLongClick,
      this.onMapError});

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

    final overlayChannel = ChannelType.overlay.channelWithId(viewId);
    controller = KakaoMapController(channel, overlayChannel: overlayChannel);
  }

  void _setEventHandler() {
    int bitMask = EventType.onPoiClick.id | EventType.onLodPoiClick.id;
    if (widget.onCameraMoveStart != null) {
      bitMask |= EventType.onCameraMoveStart.id;
    }
    if (widget.onCameraMoveEnd != null) bitMask |= EventType.onCameraMoveEnd.id;
    if (widget.onCompassClick != null) bitMask |= EventType.onCompassClick.id;
    if (widget.onMapClick != null) bitMask |= EventType.onMapClick.id;
    if (widget.onTerrainClick != null) bitMask |= EventType.onTerrainClick.id;
    if (widget.onTerrainLongClick != null) {
      bitMask |= EventType.onTerrainLongClick.id;
    }
    channel.invokeMethod("setEventHandler", bitMask);
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
    _setEventHandler();
    widget.onMapReady.call(controller);
  }

  @override
  void onCameraMoveStart(GestureType gestureType) {
    widget.onCameraMoveStart?.call(gestureType);
  }

  @override
  void onCameraMoveEnd(CameraPosition position, GestureType gestureType) {
    widget.onCameraMoveEnd?.call(position, gestureType);
  }

  @override
  void onCompassClick() {
    widget.onCompassClick?.call();
  }

  @override
  void onPoiClick(String layerId, String poiId) {
    final layer = controller.getLabelLayer(layerId);
    final poi = layer!.getPoi(poiId);
    poi?._onClick?.call();
    widget.onPoiClick?.call(layer, poi!);
  }

  @override
  void onLodPoiClick(String layerId, String poiId) {
    final layer = controller.getLodLabelLayer(layerId);
    final poi = layer!.getLodPoi(poiId);
    poi?._onClick?.call();
    widget.onLodPoiClick?.call(layer, poi!);
  }

  @override
  void onMapClick(KPoint point, LatLng position) {
    widget.onMapClick?.call(point, position);
  }

  @override
  void onTerrainClick(KPoint point, LatLng position) {
    widget.onTerrainClick?.call(point, position);
  }

  @override
  void onTerrainLongClick(KPoint point, LatLng position) {
    widget.onTerrainLongClick?.call(point, position);
  }
}
