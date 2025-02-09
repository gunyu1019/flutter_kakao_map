import KakaoMapsSDK


internal class KakaoMapDelegate: NSObject, MapControllerDelegate {
    private let option: MapviewInfo
    private let sender: KakaoMapControllerSender

    init(
        controller: KMController,
        sender: KakaoMapControllerSender,
        option: MapviewInfo
    ) {
        self.controller = controller
        self.sender = sender
        self.option = option
        super.init()
    }
    
    func addViews() {
        controller.addView(option)
    }
    
    func addViewSucceeded(_ viewName: String, viewInfoName: String) {
        sender.onMapReady(
            kakaoMap: self.controller.getView(viewName) as! KakaoMap
        )
    }
    
    func addViewFailed(_ viewName: String, viewInfoName: String) {
        sender.onMapError(
            error: MapViewLoadFailed()
        )
    }
    
    func authenticationFailed(_ errorCode: Int, desc: String) {
        sender.onMapError(
            error: AuthenticatedFailed(errorCode: errorCode, message: desc)
        )
    }
    
    func containerDidResized(_ size: CGSize) {
        (controller.getView("map_view") as? KakaoMap)?.viewRect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size)
    }
    
    var controller: KMController;
}
