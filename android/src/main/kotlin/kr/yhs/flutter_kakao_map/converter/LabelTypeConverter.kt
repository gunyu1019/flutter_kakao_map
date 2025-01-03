package kr.yhs.flutter_kakao_map.converter

import com.kakao.vectormap.label.LabelManager
import com.kakao.vectormap.KakaoMap
import com.kakao.vectormap.label.LabelOptions
import com.kakao.vectormap.label.LabelLayer
import com.kakao.vectormap.label.LabelLayerOptions
import com.kakao.vectormap.label.CompetitionType
import com.kakao.vectormap.label.CompetitionUnit
import com.kakao.vectormap.label.OrderingType
import com.kakao.vectormap.label.LabelTextStyle
import com.kakao.vectormap.label.LabelStyle
import com.kakao.vectormap.label.LabelTransition
import com.kakao.vectormap.label.Transition
import com.kakao.vectormap.label.TransformMethod
import com.kakao.vectormap.label.LabelTextBuilder
import com.kakao.vectormap.label.LabelStyles
import com.kakao.vectormap.label.Label
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asMap
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asBoolean
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asDouble
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asInt
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asList
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asFloat
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asLong
import kr.yhs.flutter_kakao_map.converter.PrimitiveTypeConverter.asString
import kr.yhs.flutter_kakao_map.converter.ReferenceTypeConverter.asPoint
import kr.yhs.flutter_kakao_map.converter.ReferenceTypeConverter.asBitmap
import kr.yhs.flutter_kakao_map.converter.CameraTypeConverter.asLatLng
import kr.yhs.flutter_kakao_map.converter.CameraTypeConverter.toMessageable
import com.kakao.vectormap.utils.MapUtils
import android.util.Log


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

    fun Any.asLabelTransition(): LabelTransition = asMap<Any?>().let { rawPayload: Map<String, Any?> ->
        LabelTransition.from(
            Transition.getEnum(rawPayload["enterence"]!!.asInt()),
            Transition.getEnum(rawPayload["exit"]!!.asInt())
        )
    }

    fun Any.asLabelStyle(): LabelStyle = asMap<Any?>().let { rawPayload: Map<String, Any?> ->
        val labelStyle = if (rawPayload.get("icon") != null) {
            LabelStyle.from(rawPayload["icon"]!!.asBitmap())
        } else {
            LabelStyle.from()
        }
        labelStyle.apply {
            rawPayload["anchor"]?.asPoint().let(::setAnchorPoint)
            rawPayload["applyDpScale"]?.asBoolean()?.let(::setApplyDpScale)
            rawPayload["iconTransition"]?.let{ element -> element.asLabelTransition() }?.let(::setIconTransition)
            rawPayload["textTransition"]?.let{ element -> element.asLabelTransition() }?.let(::setTextTransition)
            rawPayload["padding"]?.asFloat()?.let(::setPadding)
            rawPayload["textGravity"]?.asInt()?.let(::setTextGravity)
            rawPayload["textStyle"]?.asList<Map<String, Any>>()?.map { 
                element -> element.asLabelTextStyle() 
            }?.toTypedArray()?.let { 
                argument -> setTextStyles(*argument)
            }

            rawPayload["zoomLevel"]?.asInt()?.let(::setZoomLevel)
        }
    }

    fun Any.asLabelStyles(labelManager: LabelManager): LabelStyles? = asMap<Any?>().let { rawPayload: Map<String, Any?> ->
        if (rawPayload["styleId"] != null && rawPayload["styles"] != null) {
            LabelStyles.from(
                rawPayload["styleId"]!!.asString(),
                rawPayload["styles"]!!.asList<Map<String, Any>>().map { 
                    element -> element.asLabelStyle() 
                }
            ).let(labelManager::addLabelStyles)
        } else if (rawPayload["styleId"] != null) {
            labelManager.getLabelStyles(rawPayload["styleId"]!!.asString())
        } else if (rawPayload["styles"] != null) {
            LabelStyles.from(
                rawPayload["styles"]!!.asList<Map<String, Any>>().map { 
                    element -> element.asLabelStyle() 
                }
            ).let(labelManager::addLabelStyles)
        } else {
            null
        }
    }

    fun Any.asLabelOptions(labelManager: LabelManager): LabelOptions = asMap<Any?>().let { rawPayload: Map<String, Any?> ->
        LabelOptions.from(
            (rawPayload["id"]?.asString()) ?: MapUtils.getUniqueId(),
            rawPayload.asLatLng()
        ).apply {
            rawPayload.asLabelStyles(labelManager)?.let(::setStyles)
            rawPayload["rank"]?.asLong()?.let(::setRank)
            rawPayload["clickable"]?.asBoolean()?.let(::setClickable)
            rawPayload["visible"]?.asBoolean()?.let(::setVisible)

            if (rawPayload["transformMethod"] != null) {
                rawPayload["transformMethod"]?.asInt()?.let(TransformMethod::getEnum).let(::setTransform)
            }
            rawPayload["text"]?.asString()?.let{ element ->
                val labelText = LabelTextBuilder()
                labelText.setTexts(*element.split("\n").toTypedArray())
                labelText
            }?.let(::setTexts)
            rawPayload["tag"]?.asString()?.let(::setTag)
        }
    }
}