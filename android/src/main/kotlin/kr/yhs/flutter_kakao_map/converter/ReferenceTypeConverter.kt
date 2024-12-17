package kr.yhs.flutter_kakao_map.converter

import com.kakao.vectormap.LatLng
import com.kakao.vectormap.camera.CameraPosition
import com.kakao.vectormap.camera.CameraAnimation
import com.kakao.vectormap.camera.CameraUpdate
import com.kakao.vectormap.camera.CameraUpdateFactory
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asMap


object ReferenceTypeConverter {
    fun Any.asLatLng(): LatLng = asMap<Double>().let { rawPayload: Map<String, Double> ->
        LatLng.from(
            rawPayload["latitude"]!!,
            rawPayload["longitude"]!!
        )
    }

    fun LatLng.toMessageable(): Map<String, Double> = mapOf(
        "latitude" to latitude,
        "longitude" to longitude
    )

    fun Any.asCameraPosition(): CameraPosition = asMap<Any>().let { rawPayload: Map<String, Any> ->
        CameraPosition.from(
            rawPayload["latitude"] as Double,
            rawPayload["longitude"] as Double,
            rawPayload["zoomLevel"] as Int? ?: -1,
            rawPayload["tiltAngle"] as Double? ?: -1.0,
            rawPayload["rotationAngle"] as Double? ?: -1.0,
            rawPayload["height"] as Double? ?: -1.0,
        )
    }

    fun CameraPosition.toMessageable(): Map<String, Any> = mapOf(
        "latitude" to position.latitude,
        "longitude" to position.longitude,
        "zoomLevel" to zoomLevel,
        "tiltAngle" to tiltAngle,
        "rotationAngle" to rotationAngle,
        "height" to height
    )

    fun Any.asCameraAnimation(): CameraAnimation = asMap<Any>().let { rawPayload: Map<String, Any?> ->
        CameraAnimation.from(
            rawPayload["duration"] as Int,
            rawPayload["autoElevation"] as Boolean? ?: false, 
            rawPayload["isConsecutive"] as Boolean? ?: false
        )
    }

    fun Any.asCameraUpdate(): CameraUpdate = asMap<Any>().let { rawPayload: Map<String, Any> ->
        val type = rawPayload.getOrDefault("type", -1) as Int
        when(type) {
            CameraUpdateFactory.NewCenterPoint -> CameraUpdateFactory.newCenterPosition(rawPayload.asLatLng(), rawPayload.getOrDefault("zoomLevel", -1) as Int)
            else -> throw NotImplementedError("Wrong CameraUpdate type")
        }
    }
}