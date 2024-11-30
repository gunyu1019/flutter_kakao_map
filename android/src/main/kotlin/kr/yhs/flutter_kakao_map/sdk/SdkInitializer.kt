package kr.yhs.flutter_kakao_map.SDK

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall
import kotlin.Result
import com.kakao.vectormap.KakaoMapSdk

class SdkInitializer(
    private val context: Context,
    private val messenger: BinaryMessenger
): MethodChannel.MethodCallHandler {
    private val channel: MethodChannel = MethodChannel(messenger, SDK_CHANNEL_NAME)
    
    init {
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(method: MethodCall, result: MethodChannel.Result) {
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

    companion object {
        private const val SDK_CHANNEL_NAME = "flutter_kakao_map_sdk"
    }
}