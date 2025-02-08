internal protocol KakaoMapControllerHandler {
    func getCameraPosition(onSuccess: @escaping (_ cameraPosition: Dictionary<String, Any>) -> Void)

    func moveCamera(
        cameraUpdate: CameraUpdate,
        cameraAnimation: CameraAnimationOptions?,
        onSuccess: () -> Void
    )
}

internal extension KakaoMapControllerHandler {
    func handle(call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
            case "getCameraPosition": getCameraPosition(onSuccess: result)
            case "moveCamera": moveCamera(
                
                onSuccess: result
            )
            default: result(FlutterMethodNotImplemented)
        }
    }
}