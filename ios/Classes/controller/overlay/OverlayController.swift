import KakaoMapsSDK
import Flutter


internal class OverlayController: LabelControllerHandler {
    private let channel: FlutterMethodChannel
    private let kakaoMap: KakaoMap

    let labelManager: LabelManager

    init (channel: FlutterMethodChannel, kakaoMap: KakaoMap) {
        self.channel = channel
        self.kakaoMap = kakaoMap
        
        self.labelManager = kakaoMap.getLabelManager()
        
        self.labelManager.addLabelLayer(
            option: LabelLayerOptions(
                layerID: "label_default_layer",
                competitionType: .none,
                competitionUnit: .poi,
                orderType: .rank,
                zOrder: 10001
            )
        )

        channel.setMethodCallHandler(handle)
    }

    func handle(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = asDict(call.arguments!)
        let overlayType = OverlayType(rawValue: asInt(arguments["type"]!))
        switch overlayType {
        case .label: labelHandle(call: call, result: result)
        default: result(FlutterMethodNotImplemented)
        }
    }

    func createLabelLayer(option: LabelLayerOptions, onSuccess: (Any?) -> Void) {
        self.labelManager.addLabelLayer(option: option)
        onSuccess(nil)
    }

    func removeLabelLayer(layerId: String, onSuccess: (Any?) -> Void) {
        self.labelManager.removeLabelLayer(layerID: layerId)
        onSuccess(nil)
    }

    func addPoiStyle(style: PoiStyle, onSuccess: (String) -> Void) {
        self.labelManager.addPoiStyle(style)
        onSuccess(style.styleID)
    }

    func addPoi(layer: LabelLayer, poi: PoiOptions, position: MapPoint, visible: Bool, onSuccess: @escaping (String) -> Void) {
        let poiInstance = layer.addPoi(option: poi, at: position)
        if (visible && !poiInstance.isShow) {
            poiInstance?.show()
        }
        onSuccess(poiInstance!.itemID)
    }

    func removePoi(layer: LabelLayer, poiId: String, onSuccess: (Any?) -> Void) {
        layer.removePoi(poiID: poiId)
        onSuccess(nil)
    }
}
