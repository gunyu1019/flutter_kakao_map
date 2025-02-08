internal class KakaoMapController : KakaoMapControllerSender, KakaoMapControllerHandler {
    private let channel: FlutterMethodChannel
    private let overlayChannel: FlutterMethodChannel
    private let kakaoMap: KakaoMap

    init (
        channel: FlutterMethodChannel,
        overlayChannel: FlutterMethodChannel,
        kakaoMap: KakaoMap
    ) {
        self.channel = channel
        self.overlayChannel = overlayChannel
        self.kakaoMap = kakaoMap

        channel.setMethodCallHandler(handle)
    }

    func getCameraPosition(onSuccess: @escaping (_ cameraPosition: Dictionary<String, Any>) -> Void) {
        let position = kakaoMap.getPosition(CGPoint(x: 0.5, y: 0.5))
        var payload: Dictionary<String, Any> = position.toMessageable()
        payload["zoomLevel"] = kakaoMap.zoomLevel
        payload["tiltAngle"] = kakaoMap.tiltAngle
        payload["rotationAngle"] = kakaoMap.rotationAngle
        payload["height"] = kakaoMap.cameraHeight
        onSuccess(payload)
        return
    }

    func moveCamera(
        cameraUpdate: CameraUpdate,
        cameraAnimation: CameraAnimationOptions?,
        onSuccess: () -> Void
    ) {
        if (cameraAnimation == nil) {
            kakaoMap.moveCamera(cameraUpdate, callback: onSuccess)
        }
        kakaoMap.animateCamera(cameraUpdate, cameraAnimation, callback: onSuccess)
        return
    }

    func onMapReady() {
        channel.invokeMethod("onMapReady")
    }

    func onMapDestroy() {
        channel.invokeMethod("onMapDestroy")
    }

    func onMapResumed() {
        channel.invokeMethod("onMapResumed")
    }

    func onMapPaused() {
        channel.invokeMethod("onMapPaused")
    }

    func onMapError(error: Error) {
        if error is BaseError {
            channel.invokeMethod("onMapError", arguments: [
                "className": "\(error.self)",
                "message": (error as! BaseError).errorCode,
                "errorCode": (error as! BaseError).message
            ])
            return
        }
        channel.invokeMethod("onMapError", arguments: [
            "className": "\(error.self)"
        ])
    }
}