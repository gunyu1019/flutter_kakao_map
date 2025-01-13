package kr.yhs.flutter_kakao_map.converter

import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asMap
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asString
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asDouble
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asInt
import kr.yhs.flutter_kakao_map.FlutterKakaoMapPlugin
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.PointF
import java.io.ByteArrayInputStream


object ReferenceTypeConverter {
    fun Any.asBitmap(): Bitmap = asMap<Any?>().let { rawPayload: Map<String, Any?> ->
        val width = rawPayload["width"]!!.asInt();
        val height = rawPayload["height"]!!.asInt();
        if (rawPayload["type"] == 2) {
            val inputStream = ByteArrayInputStream(rawPayload["data"] as ByteArray)
            Bitmap.createScaledBitmap(
                BitmapFactory.decodeStream(inputStream), 
                width, height, true
            )
        } else if (rawPayload["type"] == 0) {
            val path = rawPayload["path"]!!.asString()
            Bitmap.createScaledBitmap(
                BitmapFactory.decodeStream(FlutterKakaoMapPlugin.getAsset(path)), 
                width, height, true
            )
        } else {
            val path = rawPayload["path"]!!.asString()
            Bitmap.createScaledBitmap(
                BitmapFactory.decodeFile(path), 
                width, height, true
            )
        }
    }

    fun Any.asPoint(): PointF = asMap<Float>().let { rawPayload: Map<String, Float> ->
        PointF(rawPayload["x"]!!, rawPayload["y"]!!)
    }
}