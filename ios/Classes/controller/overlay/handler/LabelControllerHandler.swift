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
        switch call.method {

            default: result(FlutterMethodNotImplemented)
        }
    }
}