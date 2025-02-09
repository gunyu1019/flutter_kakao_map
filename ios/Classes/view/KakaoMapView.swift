import Flutter
import KakaoMapsSDK


internal class KakaoMapView: NSObject, FlutterPlatformView {  // UIApplicationDelegate
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
            overlayChannel: overlayChannel
        )
        super.init()
        
        eventDelegate = KakaoMapDelegate(
            controller: self.kakaoMap,
            sender: controller,
            option: option
        )
        self.kakaoMap.delegate = eventDelegate
        
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onViewPaused),
            name: UIApplication.willResignActiveNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onViewResume),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
        self.kakaoMap.prepareEngine()
    }
    
    func view() -> UIView {
        self.kakaoMap.activateEngine()
        return KMView
    }

    @objc func onViewPaused() {
        self.kakaoMap.pauseEngine()
    }

    @objc func onViewResume() {
        self.kakaoMap.activateEngine()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        self.kakaoMap.pauseEngine()
        self.kakaoMap.resetEngine()
    }
}

