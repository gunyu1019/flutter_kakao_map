import Flutter
import KakaoMapsSDK

internal class SdkInitializer: NSObject {
    private let channel: FlutterMethodChannel
    private var isInitialzed: Bool
    
    init (channel: FlutterMethodChannel) {
        self.channel = channel
        self.isInitialzed = false
        super.init()
        
        channel.setMethodCallHandler(self.handle)
    }
    
    private func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = asDict(call.arguments!)
        switch call.method {
        case "initialize":
            initalize(appKey: asString(arguments["appKey"]!), onSuccess: result)
        case "isInitialize":
            result(isInitialzed)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func initalize(appKey: String, onSuccess: (Any?) -> Void) {
        SDKInitializer.InitSDK(appKey: appKey)
        self.isInitialzed = true
        onSuccess(nil)
    }
}
