import Flutter
import KakaoMapsSDK

internal class KakaoMapController : KakaoMapControllerSender, KakaoMapControllerHandler {
    private let channel: FlutterMethodChannel
    private let overlayChannel: FlutterMethodChannel
    
    private var kakaoMap: KakaoMap {
        get {
            return (kmController.getView("mapView") as! KakaoMap)
        }
    }
    private let kmController: KMController

    init (
        channel: FlutterMethodChannel,
        overlayChannel: FlutterMethodChannel,
        kmController: KMController
    ) {
        self.channel = channel
        self.overlayChannel = overlayChannel
        self.kmController = kmController

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

    func onMapReady() {
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
