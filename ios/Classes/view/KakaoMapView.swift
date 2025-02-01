import Flutter
import KakaoMapsSDK


internal class KakaoMapView: NSObject, FlutterPlatformView {
    private let kakaoMap: KMViewContainer;
    private let controller: KMController;
    private var eventDelegate: KakaoMapDelegate!
    
    init(frame: CGRect) {
        self.kakaoMap = KMViewContainer()
        self.controller = KMController(viewContainer: kakaoMap)
        super.init()
        
        eventDelegate = KakaoMapDelegate(controller: self.controller)
        self.controller.delegate = eventDelegate
    }
    
    func view() -> UIView {
        self.controller.prepareEngine()
        self.controller.activateEngine()
        return kakaoMap
    }
}

