part of '../flutter_kakao_map.dart';

class KakaoMap extends StatefulWidget {
  final KakaoMapOption? option;

  const KakaoMap({
    super.key,
    this.option
  });

  @override
  State<StatefulWidget> createState() => _KakaoMapState();
}

class _KakaoMapState extends State<KakaoMap> {
  static const VIEW_TYPE = "plugin/kakao_map";
  late final MethodChannel channel;

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
    channel.invokeMethod("start");
  }
}
