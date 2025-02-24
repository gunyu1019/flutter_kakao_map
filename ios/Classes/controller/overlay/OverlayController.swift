import KakaoMapsSDK
import Flutter


internal class OverlayController: LabelControllerHandler, LodLabelControllerHandler {
    private let channel: FlutterMethodChannel
    private let kakaoMap: KakaoMap

    let labelManager: LabelManager

    init (channel: FlutterMethodChannel, kakaoMap: KakaoMap) {
        self.channel = channel
        self.kakaoMap = kakaoMap
        
        self.labelManager = kakaoMap.getLabelManager()

        setupInitLayer()
        channel.setMethodCallHandler(handle)
    }

    func setupInitLayer() {
        self.labelManager.addLabelLayer(
            option: LabelLayerOptions(
                layerID: "label_default_layer",
                competitionType: .none,
                competitionUnit: .poi,
                orderType: .rank,
                zOrder: 10001
            )
        )
        self.labelManager.addLodLabelLayer(
            option: LodLabelLayerOptions(
                layerID: "lodLabel_default_layer",
                competitionType: .none,
                competitionUnit: .poi,
                orderType: .rank,
                zOrder: 10001,
                radius: 20.0
            )
        )
    }

    func handle(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = asDict(call.arguments!)
        let overlayType = OverlayType(rawValue: asInt(arguments["type"]!))
        switch overlayType {
        case .label: labelHandle(call: call, result: result)
        case .lodLabel: lodLabelHandle(call: call, result: result)
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
        if (visible && !(poiInstance?.isShow ?? false)) {
            poiInstance?.show()
        }
        onSuccess(poiInstance!.itemID)
    }

    func removePoi(layer: LabelLayer, poiId: String, onSuccess: (Any?) -> Void) {
        layer.removePoi(poiID: poiId)
        onSuccess(nil)
    }

    func addPolylineText(layer: LabelLayer, label: WaveTextOptions, visible: Bool, onSuccess: (String) -> Void) {
        let waveTextInstance = layer.addWaveText(label)
        if (visible && !(waveTextInstance?.isShow ?? false)) {
            waveTextInstance?.show()
        }
        onSuccess(waveTextInstance!.itemID)
    }

    func removePolylineText(layer: LabelLayer, labelId: String, onSuccess: (Any?) -> Void) {
        layer.removeWaveText(waveTextID: labelId)
        onSuccess(nil)
    }


    func changePoiPixelOffset(poi: Poi, offset: CGPoint, onSuccess: (Any?) -> Void) {
        poi.pixelOffset = offset
        onSuccess(nil)
    }

    func changePoiVisible(poi: Poi, visible: Bool, autoMove: Bool, onSuccess: (Any?) -> Void) {
        if (visible && autoMove) {
            poi.showWithAutoMove()
        } else if (visible) {
            poi.show()
        } else {
            poi.hide()
        }
        onSuccess(nil)
    }

    func changePoiStyle(poi: Poi, styleId: String, transition: Bool, onSuccess: (Any?) -> Void) {
        poi.changeStyle(styleID: styleId, enableTransition: transition)
        onSuccess(nil)
    }

    func changePoiText(poi: Poi, styleId: String, text: String, transition: Bool, onSuccess: (Any?) -> Void) {
        let poiText = asString(text).components(separatedBy: "\n").enumerated().map {
            (index, element) in PoiText(text: element, styleIndex: UInt(index))
        }
        poi.changeTextAndStyle(texts: poiText, styleID: styleId, enableTransition: transition)
        onSuccess(nil)
    }

    func invalidatePoi(
        poi: Poi,
        styleId: String,
        text: String,
        transition: Bool,
        onSuccess: (Any?) -> Void
    ) {
        let poiText = asString(text).components(separatedBy: "\n").enumerated().map {
            (index, element) in PoiText(text: element, styleIndex: UInt(index))
        }
        poi.changeTextAndStyle(texts: poiText, styleID: styleId, enableTransition: transition)
        onSuccess(nil)
    }
    
    func movePoi(poi: Poi, position: MapPoint, duration: UInt?, onSuccess: (Any?) -> Void) {
        if (duration == nil || duration is NSNull) {
            poi.position = position
        } else {
            poi.moveAt(position, duration: duration!)
        }
        onSuccess(nil)
    }

    func rotatePoi(poi: Poi, angle: Double, duration: UInt?, onSuccess: (Any?) -> Void) {
        if (duration == nil || duration is NSNull) {
            poi.orientation = angle
        } else {
            poi.rotateAt(angle, duration: duration!)
        }
        onSuccess(nil)
    }

    func rankPoi(poi: Poi, rank: Int, onSuccess: (Any?) -> Void) {
        poi.rank = rank
        onSuccess(nil)
    }

    func createLodLabelLayer(option: LodLabelLayerOptions, onSuccess: (Any?) -> Void) {
        self.labelManager.addLodLabelLayer(option: option)
        onSuccess(nil)
    }
    
    func removeLodLabelLayer(layerId: String, onSuccess: (Any?) -> Void) {
        self.labelManager.removeLodLabelLayer(layerID: layerId)
        onSuccess(nil)
    }
    
    func addLodPoi(layer: LodLabelLayer, poi: PoiOptions, position: MapPoint, visible: Bool, onSuccess: @escaping (String) -> Void) {
        let poiInstance = layer.addLodPoi(option: poi, at: position)
        if (visible && !(poiInstance?.isShow ?? false)) {
            poiInstance?.show()
        }
        onSuccess(poiInstance!.itemID)
    }
    
    func removeLodPoi(layer: LodLabelLayer, poiId: String, onSuccess: (Any?) -> Void) {
        layer.removeLodPoi(poiID: poiId)
        onSuccess(nil)
    }
    
    func changeLodPoiVisible(poi: LodPoi, visible: Bool, autoMove: Bool, onSuccess: (Any?) -> Void) {
        if (visible && autoMove) {
            poi.showWithAutoMove()
        } else if (visible) {
            poi.show()
        } else {
            poi.hide()
        }
        onSuccess(nil)
    }
    
    func changeLodPoiStyle(poi: LodPoi, styleId: String, transition: Bool, onSuccess: (Any?) -> Void) {
        poi.changeStyle(styleID: styleId, enableTransition: transition)
        onSuccess(nil)
    }
    
    func changeLodPoiText(poi: LodPoi, styleId: String, text: String, transition: Bool, onSuccess: (Any?) -> Void) {
        let poiText = asString(text).components(separatedBy: "\n").enumerated().map {
            (index, element) in PoiText(text: element, styleIndex: UInt(index))
        }
        poi.changeTextAndStyle(texts: poiText, styleID: styleId, enableTransition: transition)
        onSuccess(nil)
    }
    
    func rankLodPoi(poi: LodPoi, rank: Int, onSuccess: (Any?) -> Void) {
        poi.rank = rank
        onSuccess(nil)
    }
}
