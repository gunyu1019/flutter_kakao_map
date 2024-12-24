package kr.yhs.flutter_kakao_map.converter

import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asMap
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asString
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asDouble
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asInt
import kr.yhs.flutter_kakao_map.FlutterKakaoMapPlugin
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import java.io.ByteArrayInputStream


object ReferenceTypeConverter {
    fun Any.asBitmap(): Bitmap = asMap<Any?>().let { rawPayload: Map<String, Any?> ->
        if (rawPayload["type"] == "data") {
            val inputStream = ByteArrayInputStream(rawPayload["data"] as ByteArray)
            BitmapFactory.decodeStream(inputStream)
        } else if (rawPayload["type"] == "asset") {
            val path = rawPayload["path"]!!.asString()
            BitmapFactory.decodeStream(FlutterKakaoMapPlugin.getAsset(path))
        } else {
            val path = rawPayload["path"]!!.asString()
            BitmapFactory.decodeFile(path)
        }
    }
}