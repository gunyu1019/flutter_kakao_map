package kr.yhs.flutter_kakao_map.SDK

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall
import kotlin.Result
import com.kakao.vectormap.KakaoMapSdk
import kr.yhs.flutter_kakao_map.FlutterKakaoMapPlugin

class SdkInitializer(
    private val context: Context,
    private val channel: MethodChannel
 ) {
    init {
        channel.setMethodCallHandler(::handler)
    }

    private fun handler(method: MethodCall, result: MethodChannel.Result) {
        if (method.method == "initalize") {
            val appKey: String? = method.argument("appKey")

            if (appKey == null) {
                result.error("TypeError", "Unknown argument: appKey", null);
                return
            }

            KakaoMapSdk.init(context, appKey)
            result.success(null)
        }
    }
}