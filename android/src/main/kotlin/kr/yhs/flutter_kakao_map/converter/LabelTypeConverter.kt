package kr.yhs.flutter_kakao_map.converter

import com.kakao.vectormap.label.LabelManager
import com.kakao.vectormap.label.LabelOptions
import com.kakao.vectormap.label.LabelLayer
import com.kakao.vectormap.label.CompetitionType
import com.kakao.vectormap.label.CompetitionUnit
import com.kakao.vectormap.label.OrderingType
import com.kakao.vectormap.label.LabelTextStyle
import com.kakao.vectormap.label.LabelStyle
import com.kakao.vectormap.label.LabelTransition
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asMap
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asBoolean
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asDouble
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asInt
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asFloat
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asString
import kr.yhs.flutter_kakao_map.converter.ReferenceTypeConverter.asPoint
import kr.yhs.flutter_kakao_map.converter.ReferenceTypeConverter.asBitmap


object LabelTypeConverter {
    fun Any.asLabelTextStyle(): LabelTextStyle = asMap<Any?>().let { rawPayload: Map<String, Any?> ->
        LabelTextStyle.from(
            rawPayload["size"]!!.asInt(), 
            rawPayload["color"]!!.asInt(),
            (rawPayload["strokeSize"] ?: 0).asInt(),
            (rawPayload["strokeColor"] ?: 0).asInt(),
        ).apply {
            rawPayload.get("font")?.asString()?.let(::setFont)
            rawPayload.get("characterSpace")?.asInt()?.let(::setCharacterSpace)
            rawPayload.get("lineSpace")?.asFloat()?.let(::setLineSpace)
            rawPayload.get("aspectRatio")?.asFloat()?.let(::setAspectRatio)
        }
    }

    fun Any.asLabelStyle(): LabelStyle = asMap<Any?>().let { rawPayload: Map<String, Any?> ->
        val labelStyle = if (rawPayload.get("icon") != null) {
            LabelStyle.from(rawPayload["icon"]!!.asBitmap())
        } else {
            LabelStyle.from()
        }
        labelStyle.apply {
            rawPayload["anchorPoint"]?.asPoint().let(::setAnchorPoint)
            rawPayload["applyDpScale"]?.asBoolean()?.let(::setApplyDpScale​)
            // rawPayload["iconTransition"]?.let(LabelTransition.)?.let(::setIconTransition​)
            rawPayload["padding"]?.asFloat()?.let(::setPadding)
            rawPayload["textGravity"]?.asInt()?.let(::setTextGravity)
            // (rawPayload["textStyle"] as List<Map<String, Any>>).map(::asLabelTextStyle().let(::setTextStyles))
            // rawPayload["textTransition"]?.let(LabelTransition.)?.let(::setTextTransition​)
            rawPayload["zoomLevel"]?.asInt()?.let(::setZoomLevel)
        }
    }
}