import Flutter
import KakaoMapsSDK
import UIKit


public class FlutterKakaoMapsPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let kakaoMapFactory = KakaoMapViewFactory(messagenger: registrar.messenger())
        registrar.register(kakaoMapFactory, withId: MAP_VIEW_TYPE_ID)
        
        let sdkChannel = FlutterMethodChannel(name: SDK_CHANNEL_NAME, binaryMessenger: registrar.messenger())
        let _ = SdkInitializer(channel: sdkChannel)
    }
    
    private static let MAP_VIEW_TYPE_ID = "plugin/kakao_map"
    
    private static let SDK_CHANNEL_NAME = "flutter_kakao_maps_sdk"
    private static let OVERLAY_CHANNEL_NAME = "flutter_kakao_maps_overlay"
    private static let VIEW_CHANNEL_NAME = "flutter_kakao_maps_view"
}
