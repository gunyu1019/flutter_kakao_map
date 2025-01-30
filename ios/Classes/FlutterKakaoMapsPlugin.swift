import Flutter
import KakaoMapsSDK
import UIKit


public class FlutterKakaoMapsPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        SDKInitializer.InitSDK(appKey: "SDK KEY")
        
        let kakaoMapFactory = KakaoMapViewFactory(messagenger: registrar.messenger())
        registrar.register(kakaoMapFactory, withId: MAP_VIEW_TYPE_ID)
    }
    
    private static let MAP_VIEW_TYPE_ID = "plugin/kakao_map"
}
