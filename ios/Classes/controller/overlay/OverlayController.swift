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

    func addPolylineText(layer: LabelLayer, label: WaveTextOptions, visible: Bool, onSuccess: (String) -> Void) {
        let waveTextInstance = layer.addWaveText(option: label, at: position)
        if (visible && !waveTextInstance.isShow) {
            waveTextInstance?.show()
        }
        onSuccess(waveTextInstance!.itemID)
    }

    func removePolylineText(layer: LabelLayer, labelId: String, onSuccess: (Any?) -> Void) {
        layer.removeWaveText(waveTextID: poiId)
        onSuccess(nil)
    }


    func changePoiPixelOffset(poi: Poi, offset: CGPoint, onSuccess: (Any?) -> Unit) {
        poi.pixelOffset = offset
        onSuccess(nil)
    }

    func changePoiVisible(poi: Poi, visible: Bool, onSuccess: (Any?) -> Unit) {
        if (visible) {
            poi.show()
        } else {
            poi.hide()
        }
    }

    func changePoiStyle(poi: Poi, styleId: String, transition: Bool, onSuccess: (Any?) -> Unit) {
        poi.changeStyle(styleID: styleId, enableTransition: transition)
        onSuccess(nil)
    }

    func changePoiText(poi: Poi, text: String, transition: Bool, onSuccess: (Any?) -> Unit) {
        // poi.changeTextAndStyle(styleID: ??, text: text, enableTransition: transition)
        onSuccess(nil)
    }

    func invalidatePoi(
        poi: Poi,
        styleId: String,
        text: String,
        transition: Bool,
        onSuccess: (Any?) -> Unit
    ) {
        poi.changeTextAndStyle(styleID: styleId, text: text, enableTransition: transition)
        onSuccess(nil)
    }
    
    func movePoi(poi: Poi, position: MapPoint, duration: UInt?, onSuccess: (Any?) -> Unit) {
        if (duration is nil | duration is NSNull) {
            poi.position = position
        } else {
            poi.moveAt(position: position, duration: duration!)
        }
    }

    func rotatePoi(poi: Poi, angle: Double, duration: UInt?, onSuccess: (Any?) -> Unit) {
        if (duration is nil | duration is NSNull) {
            poi.orientation = angle
        } else {
            poi.rotateAt(roll: angle, duration: duration!)
        }
        onSuccess(nil)
    }

    func rankPoi(poi: Poi, rank: Int, onSuccess: (Any?) -> Unit) {
        poi.rank = rank
        onSuccess(nil)
    }
}
