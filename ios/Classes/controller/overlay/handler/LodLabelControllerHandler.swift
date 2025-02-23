import KakaoMapsSDK
import Flutter

internal protocol LodLabelControllerHandler {
    var labelManager: LabelManager { get };

    func createLodLabelLayer(option: LodLabelLayerOptions, onSuccess: (Any?) -> Void)

    func removeLodLabelLayer(layerId: String, onSuccess: (Any?) -> Void)

    func addLodPoi(layer: LodLabelLayer, poi: PoiOptions, position: MapPoint, visible: Bool, onSuccess: @escaping (String) -> Void)

    func removeLodPoi(layer: LodLabelLayer, poiId: String, onSuccess: (Any?) -> Void)
    
    func changeLodPoiVisible(poi: LodPoi, visible: Bool, onSuccess: (Any?) -> Void)

    func changeLodPoiStyle(poi: LodPoi, styleId: String, transition: Bool, onSuccess: (Any?) -> Void)

    func changeLodPoiText(poi: LodPoi, text: String, transition: Bool, onSuccess: (Any?) -> Void)

    func rankLodPoi(poi: LodPoi, rank: Int, onSuccess: (Any?) -> Void)
}

internal extension LodLabelControllerHandler {
    func lodLabelHandle(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = castSafty(call.arguments, caster: asDict)
        let layerId: String? = castSafty(arguments?["layerId"], caster: asString)
        let layer: LodLabelLayer? = layerId.flatMap { key in
            labelManager.getLodLabelLayer(layerID: key)
        }

        let poiId = castSafty(arguments?["poiId"], caster: asString)
        let poi: LodPoi? = poiId.flatMap { key in
            layer!.getLodPoi(poiID: key)
        }

        switch call.method {
        case "createLodLabelLayer": createLodLabelLayer(option: LodLabelLayerOptions(payload: arguments!), onSuccess: result)
        case "removeLodLabelLayer": removeLodLabelLayer(layerId: layerId!, onSuccess: result)
        case "addLodPoi":
            let poiArgument = asDict(arguments!["poi"]!)
            let poiOption = PoiOptions(payload: poiArgument)
            let position = MapPoint(payload: poiArgument)
            let visible = asBool(arguments!["visible"] ?? true)
            addLodPoi(layer: layer!, poi: PoiOptions(payload: poiArgument), position: position, visible: visible, onSuccess: result)
        case "removeLodPoi": removeLodPoi(layer: layer!, poiId: poiId!, onSuccess: result)
        default: result(FlutterMethodNotImplemented)
        }
    }
}
