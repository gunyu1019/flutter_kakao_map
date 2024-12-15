package kr.yhs.flutter_kakao_map.views

import android.app.Activity
import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import kr.yhs.flutter_kakao_map.FlutterKakaoMapPlugin
import kr.yhs.flutter_kakao_map.model.KakaoMapOption
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asMap


class KakaoMapViewFactory(
    private val activity: Activity,
    private val messenger: BinaryMessenger
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val channel = MethodChannel(messenger, FlutterKakaoMapPlugin.createViewChannelName(viewId))
        val convertedArgs = args!!.asMap<Any?>()

        // late init => OnMapReady method 
        val option = KakaoMapOption.fromMessageable(null, convertedArgs)
        return KakaoMapView(
            activity = activity,
            context = context,
            viewId = viewId,
            option=option,
            channel = channel
        )
    }
}