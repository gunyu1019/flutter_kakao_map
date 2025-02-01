import KakaoMapsSDK


internal class KakaoMapDelegate: NSObject, MapControllerDelegate {
    init(controller: KMController) {
        self.controller = controller
        super.init()
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
    
    var controller: KMController;
}
