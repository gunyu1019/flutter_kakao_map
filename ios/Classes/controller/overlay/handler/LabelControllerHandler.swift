import KakaoMapsSDK
import Flutter

internal protocol LabelControllerHandler {
    var labelManager: LabelManager { get };

    func createLabelLayer(option: LabelLayerOptions, onSuccess: (Any?) -> Void)

    func removeLabelLayer(layerId: String, onSuccess: (Any?) -> Void)

    func addPoiStyle(style: PoiStyle, onSuccess: (String) -> Void)

    func addPoi(layer: LabelLayer, poi: PoiOptions, position: MapPoint, visible: Bool, onSuccess: @escaping (String) -> Void)

    func removePoi(layer: LabelLayer, poiId: String, onSuccess: (Any?) -> Void)

    func addPolylineText(layer: LabelLayer, label: WaveTextOptions, visible: Bool, onSuccess: (String) -> Void)

    func removePolylineText(layer: LabelLayer, labelId: String, onSuccess: (Any?) -> Void)

    func changePoiPixelOffset(poi: Poi, offset: CGPoint, onSuccess: (Any?) -> Unit)

    func changePoiVisible(poi: Poi, visible: Bool, onSuccess: (Any?) -> Unit)

    func changePoiStyle(poi: Poi, styleId: String, transition: Bool, onSuccess: (Any?) -> Unit)

    func changePoiText(poi: Poi, text: String, transition: Bool, onSuccess: (Any?) -> Unit)

    func invalidatePoi(
        poi: Poi,
        styleId: String,
        text: String,
        transition: Bool,
        onSuccess: (Any?) -> Unit
    )
    
    func movePoi(poi: Poi, position: MapPoint, duration: UInt, onSuccess: (Any?) -> Unit)

    func rotatePoi(poi: Poi, angle: Double, duration: UInt, onSuccess: (Any?) -> Unit)

    func rankPoi(poi: Poi, rank: Int, onSuccess: (Any?) -> Unit)
}

internal extension LabelControllerHandler {
    func labelHandle(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = castSafty(call.arguments, caster: asDict)
        let layerId: String? = castSafty(arguments?["layerId"], caster: asString)
        let layer: LabelLayer? = layerId.flatMap { key in
            labelManager.getLabelLayer(layerID: key)
        }

        let poiId = castSafty(arguments?["poiId"], caster: asString)
        let poi: Poi? = poiId.flatMap { key in
            layer!.getPoi(poiID: key)
        }

        let polylineTextId = castSafty(arguments?["labelId"], caster: asString)
        let polylineText: WaveText? = polylineTextId.flatMap { key in
            layer!.getWaveText(waveTextID: key)
        }

        switch call.method {
        case "createLabelLayer": createLabelLayer(option: LabelLayerOptions(payload: arguments!), onSuccess: result)
        case "removeLabelLayer": removeLabelLayer(layerId: layerId!, onSuccess: result)
        case "addPoiStyle": addPoiStyle(style: PoiStyle(payload: arguments!), onSuccess: result)
        case "addPoi":
            let poiArgument = asDict(arguments!["poi"]!)
            let poiOption = PoiOptions(payload: poiArgument)
            let position = MapPoint(payload: poiArgument)
            let visible = asBool(arguments!["visible"] ?? true)
            addPoi(layer: layer!, poi: poiOption, position: position, visible: visible, onSuccess: result)
        case "removePoi": remvoePoi(layer: layer!, poiId: poiId, onSuccess: result)
        case "addPolylineText":
            let waveTextArgument = asDict(arguments!["poi"]!)
            let waveTextStyle = WaveTextStyle(payload: waveTextArgument["style"]!)
            labelManager.addWaveTextStyle(style: waveTextStyle)
            let waveTextOption = WaveTextOptions(payload: waveTextArgument, styleId: waveTextStyle.styleID)
            let visible = asBool(arguments!["visible"] ?? true)
            addPolylineText(layer: layer!, label: waveTextOption, visible: visible, onSuccess: result)
        case "removePolylineText": removePolylineText(layer: layer!, labelId: poiId, onSuccess: result)
        // poi Handler  
        case "changePoiPixelOffset":
            let rawPayload = ["x": asFloat(arguments!["x"]!), "y": asFloat(arguments!["y"]!)]
            let offset = CGPoint(payload: rawPayload)
            changePoiPixelOffset(poi: poi!, offset: offset, onSuccess: result)
        case "changePoiVisible":
            let visible = asBool(arguments!["visible"]!)
            changePoiVisible(poi: poi!, visible: visible, onSuccess: result)
        case "changePoiStyle":
            let styleId = asString(arguments!["styleId"]!)
            let transition = asBool(arguments!["transition"] ?? false)
            changePoiStyle(poi: poi!, styleId: styleId, transition: transition, onSuccess: result)
        case "changePoiText":
            let text = asString(arguments!["text"]!)
            let transition = asBool(arguments!["transition"] ?? false)
            changePoiStyle(poi: poi!, text: text, transition: transition, onSuccess: result)
        case "invalidatePoi":
            let styleId = asString(arguments!["styleId"]!)
            let text = asString(arguments!["text"]!)
            let transition = asBool(arguments!["transition"] ?? false)
            invalidatePoi(poi: poi!, styleId: styleId, text: text, transition: transition, onSuccess: result)
        default: result(FlutterMethodNotImplemented)
        }
    }
}
