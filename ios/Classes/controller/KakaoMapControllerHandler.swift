import KakaoMapsSDK
import Flutter

internal protocol KakaoMapControllerHandler {
    var kakaoMap: KakaoMap { get }

    func getCameraPosition(onSuccess: @escaping (_ cameraPosition: Dictionary<String, Any>) -> Void)

    func moveCamera(
        cameraUpdate: CameraUpdate,
        cameraAnimation: CameraAnimationOptions?,
        onSuccess: (Any?) -> Void
    )

    func setEventHandler(event: UInt8)

    func setGestureEnable(gestureType: GestrueType, enable: Bool, onSuccess: (Any?) -> Void)
}

internal extension KakaoMapControllerHandler {
    func handle(call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
            case "getCameraPosition": getCameraPosition(onSuccess: result)
            case "moveCamera":
            let arguments = asDict(call.arguments!)
            let cameraUpdate = asCameraUpdate(kakaoMap: self.kakaoMap, payload: asDict(arguments["cameraUpdate"]!))
            let rawCameraAnimation = castSafty(arguments["cameraAnimation"], caster: asDict)
            let cameraAnimation = rawCameraAnimation != nil ? CameraAnimationOptions(payload: rawCameraAnimation!) : nil
            moveCamera(cameraUpdate: cameraUpdate, cameraAnimation: cameraAnimation, onSuccess: result)
            case "setEventHandler": setEventHandler(event: (call.arguments! as! UInt8))
            // case "setGestureEnable":
            default: result(FlutterMethodNotImplemented)
        }
    }
}
