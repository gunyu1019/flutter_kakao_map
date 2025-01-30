import Flutter
import KakaoMapsSDK


class KakaoMapView: NSObject, FlutterPlatformView, MapControllerDelegate {
    private let kakaoMap: KMViewContainer;
    private let controller: KMController;
    
    init(frame: CGRect) {
        self.kakaoMap = KMViewContainer(frame: CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: CGSize(width: 1080.0, height: 1920.0)))
        self.controller = KMController(viewContainer: kakaoMap)
        super.init()
        
        self.controller.delegate = self
    }
    
    func view() -> UIView {
        self.controller.prepareEngine()
        self.controller.activateEngine()
        return kakaoMap
    }
    
    func addViews() {
        let mapViewInfo = MapviewInfo(viewName: "map_view", defaultPosition: nil)
        
        controller.addView(mapViewInfo)
    }
    
    func addViewSucceeded(_ viewName: String, viewInfoName: String) {
        print("GOOD")
    }
    
    func addViewFailed(_ viewName: String, viewInfoName: String) {
        print("bad")
    }
    
    func containerDidResized(_ size: CGSize) {
        (controller.getView("map_view") as? KakaoMap)?.viewRect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size)
    }
    
}

