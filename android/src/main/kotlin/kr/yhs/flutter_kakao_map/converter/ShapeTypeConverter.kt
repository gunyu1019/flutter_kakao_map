package kr.yhs.flutter_kakao_map.converter

import com.kakao.vectormap.shape.PolygonStyle
import com.kakao.vectormap.shape.PolylineStyle
import com.kakao.vectormap.shape.PolygonStyles
import com.kakao.vectormap.shape.PolylineStyles
import com.kakao.vectormap.shape.PolygonStylesSet
import com.kakao.vectormap.shape.PolylineStylesSet
import com.kakao.vectormap.utils.MapUtils
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asInt
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asString
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asDouble
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asFloat
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asMap
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asList


object ShapeTypeConverter {
    fun Any.asPolygonStyle(): PolygonStyle = asMap<Any?>().let { rawPayload: Map<String, Any?> ->
        PolygonStyle.from(
            rawPayload["color"]!!.asInt(),
            rawPayload["strokeWidth"]?.asFloat() ?: 0.0F,
            rawPayload["strokeColor"]?.asInt() ?: 0
        ).apply { 
            rawPayload["zoomLevel"]?.asInt()?.let(::setZoomLevel)
         }
    }
    
    fun Any.asPolylineStyle(): PolylineStyle = asMap<Any?>().let { rawPayload: Map<String, Any?> ->
        PolylineStyle.from(
            rawPayload["lineWidth"]!!.asFloat(),
            rawPayload["color"]!!.asInt(),
            rawPayload["strokeWidth"]?.asFloat() ?: 0.0F,
            rawPayload["strokeColor"]?.asInt() ?: 0
        ).apply { 
            rawPayload["zoomLevel"]?.asInt()?.let(::setZoomLevel)
         }
    }

    fun Any.asPolygonStyles(): PolygonStyles = asMap<Any?>().let { rawPayload: Map<String, Any?> ->
        val style: MutableList<PolygonStyle> = mutableListOf(rawPayload.asPolygonStyle())
        rawPayload["otherStyle"]?.asList<Map<String, Any?>>()?.map { e -> style.add(e.asPolygonStyle()) }
        return PolygonStyles.from(style.toList())
    }

    fun Any.asPolylineStyles(): PolylineStyles = asMap<Any?>().let { rawPayload: Map<String, Any?> ->
        val style: MutableList<PolylineStyle> = mutableListOf(rawPayload.asPolylineStyle())
        rawPayload["otherStyle"]?.asList<Map<String, Any?>>()?.map { e -> style.add(e.asPolylineStyle()) }
        return PolylineStyles.from(style.toList())
    }

    fun Any.asPolygonStylesSet(): PolygonStylesSet = asMap<Any?>().let { rawPayload: Map<String, Any?> ->
        return PolygonStylesSet.from(
            rawPayload["styleId"]?.asString() ?: MapUtils.getUniqueId() 
        ).apply { 
            rawPayload["styles"]?.asList<Any>()?.map { element ->
                addPolygonStyles(element.asPolygonStyles())    
            }
         }
    }

    fun Any.asPolylineStylesSet(): PolylineStylesSet = asMap<Any?>().let { rawPayload: Map<String, Any?> ->
        return PolylineStylesSet.from(
            rawPayload["styleId"]?.asString() ?: MapUtils.getUniqueId() 
        ).apply { 
            rawPayload["styles"]?.asList<Any>()?.map { element ->
                addPolylineStyles(element.asPolylineStyles())    
            }
         }
    }
}