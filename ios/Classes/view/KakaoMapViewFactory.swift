import Flutter

class KakaoMapViewFactory: NSObject, FlutterPlatformViewFactory {
    private let messenger: FlutterBinaryMessenger?
    
    init(messagenger: FlutterBinaryMessenger) {
        messenger = messagenger
        super.init()
    }
    
    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> any FlutterPlatformView {
        return KakaoMapView(frame: frame);
    }
    
    func createArgsCodec() -> any FlutterMessageCodec & NSObjectProtocol {
        FlutterStandardMessageCodec.sharedInstance()
    }
}
