package kr.yhs.flutter_kakao_map.SDK

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

class SdkInitializer(
    private val context: Context,
    private val messenger: BinaryMessenger
) {
    init {
        val channel = MethodChannel(context, SDK_CHANNEL_NAME)
    }

    companion object {
        private const val SDK_CHANNEL_NAME = "flutter_kakao_map_sdk"
    }
}