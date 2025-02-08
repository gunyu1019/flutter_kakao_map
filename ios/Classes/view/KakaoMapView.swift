import Flutter
import KakaoMapsSDK


internal class KakaoMapView: NSObject, FlutterPlatformView {
    private let KMView: KMViewContainer;
    private let kakaoMap: KMController;
    private var eventDelegate: KakaoMapDelegate!
    
    private let controller: KakaoMapController
    
    init(
        frame: CGRect,
        channel: FlutterMethodChannel,
        overlayChannel: FlutterMethodChannel,
        option: MapviewInfo
    ) {
        self.KMView = KMViewContainer()
        self.kakaoMap = KMController(viewContainer: KMView)
        self.controller = KakaoMapController(
            channel: channel,
            overlayChannel: overlayChannel,
            kmController: self.kakaoMap
        )
        super.init()
        
        eventDelegate = KakaoMapDelegate(controller: self.kakaoMap, sender: controller, option: option)
        self.kakaoMap.delegate = eventDelegate
        
    }
    
    func view() -> UIView {
        self.kakaoMap.prepareEngine()
        self.kakaoMap.activateEngine()
        return KMView
    }
}

