package kr.yhs.flutter_kakao_map

import com.kakao.vectormap.KakaoMapSdk
import com.kakao.vectormap.MapLifeCycleCallback
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kr.yhs.flutter_kakao_map.views.KakaoMapViewFactory
import java.lang.Exception

/** FlutterKakaoMapPlugin */
class FlutterKakaoMapPlugin: FlutterPlugin, ActivityAware {
    private lateinit var pluginBinding: FlutterPluginBinding
    private val context get() = pluginBinding.applicationContext

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        pluginBinding = binding
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) = Unit

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        val activity = binding.activity
        val kakaoMapViewFactory = KakaoMapViewFactory(activity, pluginBinding.binaryMessenger)
        pluginBinding.platformViewRegistry.registerViewFactory(
            "plugin/kakao_map",
            kakaoMapViewFactory
        )

        KakaoMapSdk.init(context, "KAKAO SDK CODE")
    }

    override fun onDetachedFromActivityForConfigChanges() = Unit

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) = Unit

    override fun onDetachedFromActivity() = Unit
}
