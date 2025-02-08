import Flutter

class KakaoMapViewFactory: NSObject, FlutterPlatformViewFactory {
    private let messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> any FlutterPlatformView {
        let channel = FlutterMethodChannel(
            name: FlutterKakaoMapsPlugin.createViewMethodChannelName(viewId),
            binaryMessenger: messenger
        )

        let arguments = asDict(args!)
        let option = KakaoMapOption(arguments)

        return KakaoMapView(frame: frame, option: option)
    }

    func createArgsCodec() -> any FlutterMessageCodec & NSObjectProtocol {
        FlutterStandardMessageCodec.sharedInstance()
    }
}
