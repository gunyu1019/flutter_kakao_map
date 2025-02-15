import KakaoMapsSDK
import Flutter

internal protocol LabelControllerHandler {
    var labelManager: LabelManager { get };

    func createLabelLayer(option: LabelLayerOptions, onSuccess: (Any?) -> Void)

    func removeLabelLayer(layerId: String, onSuccess: (Any?) -> Void)

    func addPoiStyle(style: PoiStyle, onSuccess: (String) -> Void)

    func addPoi(layer: LabelLayer, poi: PoiOptions, position: MapPoints, onSuccess: (String) -> Void)

    func removePoi(layer: LabelLayer, poiId: String, onSuccess: (Any?) -> Void)

    // func addPolylineText(layer: LabelLayer, label: WaveTextOptions, onSuccess: (String) -> Void)

    // func removePolylineText(layer: LabelLayer, labelId: String, onSuccess: (Any?) -> Void)
}

internal extension LabelControllerHandler {
    func labelHandle(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments
        let layerId = castSafty(arguments?["layerId"], caster: asString)
        if let layer: LabelLayer? = layerId {
            labelManager.getLabelLayer(layerID: layerId)
        }

        let poiId = castSafty(arguments?["poiId"], caster: asString)
        if let poi: Poi? = poiId, layer {
            layer.getPoi(poiID: poiId)
        }

        let polylineTextId = castSafty(arguments?["labelId"], caster: asString)
        if let polylineText: WaveText? = polylineTextId, layer {
            layer.getWaveText(poiID: poiId)
        }

        switch call.method {
        case "createLabelLayer": createLabelLayer(option: LabelLayerOptions(payload: call.arguments!), onSuccess: result)
        case "removeLabelLayer": removeLabelLayer(layerId: layerId!, onSuccess: result)
        case "addPoiStyle": addPoiStyle(style: PoiStyle(payload: arguments!), onSuccess: result)
        case "addPoi": addPoi(layer: layer!, poi: PoiOptions(payload: arguments!), position: MapPoints(payload: arguments!), onSuccess: result)
        default: result(FlutterMethodNotImplemented)
        }
    }
}