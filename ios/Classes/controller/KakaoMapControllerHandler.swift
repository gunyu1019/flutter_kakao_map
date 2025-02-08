import KakaoMapsSDK
import Flutter

internal protocol KakaoMapControllerHandler {
    func getCameraPosition(onSuccess: @escaping (_ cameraPosition: Dictionary<String, Any>) -> Void)

    func moveCamera(
        cameraUpdate: CameraUpdate,
        cameraAnimation: CameraAnimationOptions?,
        onSuccess: (Any?) -> Void
    )
}

internal extension KakaoMapControllerHandler {
    func handle(call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
            case "getCameraPosition": getCameraPosition(onSuccess: result)
            /* case "moveCamera": moveCamera(
                cameraUpdate: asCameraUpdate(kakaoMap: KakaoMap, payload: asDict(call.arguments["cameraUpdate"]!)),
                cameraAnimation: call.arguments["cameraAnimation"] == nil ? nil : CameraAnimationOptions(payload: asDict(call.arguments["cameraAnimation"]!)),
                onSuccess: result
            ) */
            default: result(FlutterMethodNotImplemented)
        }
    }
}
