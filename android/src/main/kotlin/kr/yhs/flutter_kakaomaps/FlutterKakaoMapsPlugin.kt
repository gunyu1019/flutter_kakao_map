package kr.yhs.flutter_kakaomaps

import com.kakao.vectormap.KakaoMapSdk
import com.kakao.vectormap.MapLifeCycleCallback
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterAssets
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kr.yhs.flutter_kakaomaps.views.KakaoMapViewFactory
import kr.yhs.flutter_kakaomaps.SDK.SdkInitializer
import java.lang.Exception
import java.io.InputStream

/** FlutterKakaoMapsPlugin */
class FlutterKakaoMapsPlugin: FlutterPlugin, ActivityAware {
    private lateinit var sdkInitalizer: SdkInitializer
    
    private val context get() = pluginBinding.applicationContext

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        pluginBinding = binding
        flutterAssets = binding.flutterAssets

        // Initalize SDK
        val channel = MethodChannel(binding.binaryMessenger, SDK_CHANNEL_NAME)
        sdkInitalizer = SdkInitializer(context, channel)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) = Unit

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        val activity = binding.activity
        val kakaoMapViewFactory = KakaoMapViewFactory(activity, pluginBinding.binaryMessenger)
        pluginBinding.platformViewRegistry.registerViewFactory(
            "plugin/kakao_map",
            kakaoMapViewFactory
        )
    }

    override fun onDetachedFromActivityForConfigChanges() = Unit

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) = Unit

    override fun onDetachedFromActivity() = Unit
    
    companion object {
        private const val BASE_CHANNEL_NAME = "flutter_kakaomaps"
        private const val SDK_CHANNEL_NAME = "${BASE_CHANNEL_NAME}_sdk"
        private const val OVERLAY_CHANNEL_NAME = "${BASE_CHANNEL_NAME}_overlay"
        private const val VIEW_CHANNEL_NAME = "${BASE_CHANNEL_NAME}_view"

        internal fun createViewChannelName(viewId: Int) = "${VIEW_CHANNEL_NAME}#${viewId}"
        internal fun createOverlayChannelName(viewId: Int) = "${OVERLAY_CHANNEL_NAME}#${viewId}"

        private lateinit var flutterAssets: FlutterAssets
        private lateinit var pluginBinding: FlutterPluginBinding

        internal fun getAsset(named: String): InputStream {
            val path = flutterAssets.getAssetFilePathByName(named)
            return pluginBinding.applicationContext.assets.open(path)
        }
    }
}
