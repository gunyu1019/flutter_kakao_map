import KakaoMapsSDK
import Flutter

internal protocol LabelControllerHandler {
    var labelManager: LabelManager { get };

    func createLabelLayer(option: LabelLayerOptions, onSuccess: (Any?) -> Void)

    func removeLabelLayer(layerId: String, onSuccess: (Any?) -> Void)

    func addPoiStyle(style: PoiStyle, onSuccess: (String) -> Void)

    func addPoi(layer: LabelLayer, poi: PoiOptions, position: MapPoint, onSuccess: @escaping (String) -> Void)

    func removePoi(layer: LabelLayer, poiId: String, onSuccess: (Any?) -> Void)

    // func addPolylineText(layer: LabelLayer, label: WaveTextOptions, onSuccess: (String) -> Void)

    // func removePolylineText(layer: LabelLayer, labelId: String, onSuccess: (Any?) -> Void)
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
            addPoi(layer: layer!, poi: PoiOptions(payload: poiArgument), position: position, onSuccess: result)
        case "removePoi": remvoePoi(layer: layer!, poiId: poiId, onSuccess: result)
        default: result(FlutterMethodNotImplemented)
        }
    }
}
