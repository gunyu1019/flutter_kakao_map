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
        
        eventDelegate = KakaoMapDelegate(controller: self.kakaoMap, sender: controller, option: option)
        self.kakaoMap.delegate = eventDelegate
        
        // FlutterKakaoMapsPlugin.registrar.addApplicationDelegate()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appDidEnterBackground),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appWillEnterForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }
    
    func view() -> UIView {
        self.kakaoMap.prepareEngine()
        self.kakaoMap.activateEngine()
        return KMView
    }

    @objc func appDidEnterBackground() {
        self.kakaoMap.pauseEngine()
    }

    @objc func appWillEnterForeground() {
        self.kakaoMap.activateEngine()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        self.kakaoMap.pauseEngine()
        self.kakaoMap.resetEngine()
    }
}

