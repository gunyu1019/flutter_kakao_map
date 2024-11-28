package kr.yhs.flutter_kakao_map.views

import android.content.Context
import android.view.View
import com.kakao.vectormap.MapView
import io.flutter.plugin.platform.PlatformView

class KakaoMapView(
    private val context: Context,
    private val viewId: Int,
    private val creationParams: Map<String, Any?>?
): PlatformView {
    private val mapView = MapView(context)

    override fun getView(): View {
        return mapView
    }

    override fun dispose() {
        TODO("Not yet implemented")
    }
}