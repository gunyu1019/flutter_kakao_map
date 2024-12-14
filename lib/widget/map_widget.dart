part of '../flutter_kakao_map.dart';

class KakaoMap extends StatefulWidget {
  final KakaoMapOption? option;

  final void Function(KakaoMapController controller) onMapReady;
  final void Function()? onMapDestroyed;
  final void Function(Exception exception)? onMapError;

  const KakaoMap({
    super.key,
    required this.onMapReady,
    this.option,
    this.onMapDestroyed,
    this.onMapError
  });

  @override
  State<StatefulWidget> createState() => _KakaoMapState();
}

class _KakaoMapState extends State<KakaoMap> with KakaoMapControllerHandler {
  static const VIEW_TYPE = "plugin/kakao_map";
  late final MethodChannel channel;
  late final KakaoMapController controller;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> rawParams = widget.option?.toMessageable() ?? (const KakaoMapOption()).toMessageable();
    return _createPlatformView(
      viewType: VIEW_TYPE,
      onPlatformViewCreated: onPlatformViewCreated,
      creationParams: rawParams
    );
  }

  void onPlatformViewCreated(int viewId) {
    channel = ChannelType.view.channelWithId(viewId as String);
    controller = KakaoMapController(channel);
  }
  
  @override
  void onMapDestroyed() {
    widget.onMapDestroyed?.call();
  }
  
  @override
  void onMapError() {
    widget.onMapError?.call();
  }
  
  @override
  void onMapReady() {
    widget.onMapReady.call(controller);
  }
}
