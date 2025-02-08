import KakaoMapsSDK


internal class KakaoMapDelegate: NSObject, MapControllerDelegate {
    private let option: KakaoMapOption
    private let sender: KakaoMapControllerSender

    init(
        controller: KMController,
        option: KakaoMapOption
    ) {
        self.controller = controller
        self.option = option
        super.init()
    }
    
    func addViews() {
        controller.addView(option)
    }
    
    func addViewSucceeded(_ viewName: String, viewInfoName: String) {
        sender.onMapReady()
    }
    
    func addViewFailed(_ viewName: String, viewInfoName: String) {
        sender.onMapReady()
    }
    
    func authenticationFailed(_ errorCode: Int, desc: String) {
        sender.onMapReady()
    }
    
    func containerDidResized(_ size: CGSize) {
        (controller.getView("map_view") as? KakaoMap)?.viewRect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size)
    }
    
    var controller: KMController;
}
