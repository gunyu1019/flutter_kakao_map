import Flutter
import KakaoMapsSDK

internal class KakaoMapController : KakaoMapControllerSender, KakaoMapControllerHandler {
    private let channel: FlutterMethodChannel
    private let overlayChannel: FlutterMethodChannel
    
    private lazy var kakaoMap: KakaoMap? = nil

    init (
        channel: FlutterMethodChannel,
        overlayChannel: FlutterMethodChannel
    ) {
        self.channel = channel
        self.overlayChannel = overlayChannel

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
        onSuccess: (Any?) -> Void
    ) {
        if (cameraAnimation == nil) {
            kakaoMap.moveCamera(cameraUpdate)
            onSuccess(nil)
            return
        }
        kakaoMap.animateCamera(cameraUpdate: cameraUpdate, options: cameraAnimation!)
        onSuccess(nil)
        return
    }

    func onMapReady(kakaoMap: KakaoMap) {
        self.kakaoMap = kakaoMap
        channel.invokeMethod("onMapReady", arguments: nil)
    }

    func onMapDestroy() {
        channel.invokeMethod("onMapDestroy", arguments: nil)
    }

    func onMapResumed() {
        channel.invokeMethod("onMapResumed", arguments: nil)
    }

    func onMapPaused() {
        channel.invokeMethod("onMapPaused", arguments: nil)
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
