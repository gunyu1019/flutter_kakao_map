import KakaoMapsSDK


internal class OverlayController: LabelControllerHandler {
    private let channel: FlutterMethodChannel
    private let kakaoMap: KakaoMap

    let labelManager: LabelManager = kakaoMap.getLabelManager()

    init (channel: FlutterMethodChannel, kakaoMap: KakaoMap) {
        self.channel = channel
        self.kakaoMap = kakaoMap

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
        self.labelManager.addPoiStyle(style: style)
        return style.styleID
    }

    func addPoi(layer: LabelLayer, poi: PoiOptions, position: MapPoints, onSuccess: (String) -> Void) {
        layer.addPoi(option: poi, position: position, callback: onSuccess($0!.itemID))
    }

    func removePoi(layer: LabelLayer, poiId: String, onSuccess: (Any?) -> Void) {
        layer.removePoi(poiID: poiId)
        onSuccess(nil)
    }
}