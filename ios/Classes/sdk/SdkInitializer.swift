import Flutter
import KakaoMapsSDK

internal class SdkInitializer: NSObject {
    let channel: FlutterMethodChannel
    
    init (channel: FlutterMethodChannel) {
        self.channel = channel
        super.init()
        
        channel.setMethodCallHandler(self.handle)
    }
    
    private func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = asDict(call.arguments!)
        switch call.method {
        case "initialize":
            initalize(appKey: asString(arguments["appKey"]), onSuccess: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func initalize(appKey: String, onSuccess: (Any?) -> Void) {
        SDKInitializer.InitSDK(appKey: appKey)
        onSuccess(nil)
    }
}
