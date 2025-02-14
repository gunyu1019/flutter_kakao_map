import Flutter
import KakaoMapsSDK

internal class KakaoMapController : KakaoMapControllerSender, KakaoMapControllerHandler {
    private let channel: FlutterMethodChannel
    private let overlayChannel: FlutterMethodChannel
    
    private var lateinitKakaoMap: KakaoMap? = nil
    internal var kakaoMap: KakaoMap {
        get {
            return self.lateinitKakaoMap!
        }
        set(value) {
            self.lateinitKakaoMap = value
        }
    }

    private let cameraListener: CameraListener

    init (
        channel: FlutterMethodChannel,
        overlayChannel: FlutterMethodChannel
    ) {
        self.channel = channel
        self.overlayChannel = overlayChannel
        
        self.cameraListener = CameraListener(channel: self.channel)
        
        channel.setMethodCallHandler(handle)
    }

    func getCameraPosition(onSuccess: @escaping (_ cameraPosition: Dictionary<String, Any>) -> Void) {
        let position = kakaoMap.getPosition(CGPoint(x: 0.5, y: 0.5))
        var payload: Dictionary<String, Any> = [
            "zoomLevel": kakaoMap.zoomLevel,
            "tiltAngle": kakaoMap.tiltAngle,
            "rotationAngle": kakaoMap.rotationAngle,
            "height": kakaoMap.cameraHeight
        ]
        payload.merge(position.toMessageable()) { current, _ in current }
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

    func setEventHandler(event: UInt8) {
        if (KakaoMapEvent.CameraMoveStart.compare(value: event)) {
            kakaoMap.addCameraWillMovedEventHandler(target: self.cameraListener, handler: CameraListener.onCameraWillMovedEvent)
        }
        if (KakaoMapEvent.CameraMoveEnd.compare(value: event)) {
            kakaoMap.addCameraStoppedEventHandler(target: self.cameraListener, handler: CameraListener.onCameraStoppedEvent)
        }
    }

    func setGestureEnable(gestureType: GestureType, enable: Bool, onSuccess: (Any?) -> Void) {
        kakaoMap.setGestureEnable(type: gestureType, enable: enable)
        onSuccess(nil)
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
