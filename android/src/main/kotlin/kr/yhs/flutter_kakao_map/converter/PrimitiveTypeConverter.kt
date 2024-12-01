package kr.yhs.flutter_kakao_map.converter

object PrimitiveTypeConverter {
    fun Any.asBoolean(): Boolean = this as Boolean
    fun Any.asDouble(): Double = this as Double
    fun Any.asInt(): Int = if (this is Long) toInt() else this as Int
    fun Any.asLong(): Long = if (this is Int) toLong() else this as Long
    
    @Suppress("UNCHECKED_CAST")
    fun Any.asMap(): Map<String, Any> = this as Map<String, Any>

    @Suppress("UNCHECKED_CAST")
    fun <T> Any.asMap(): Map<String, T> = this as Map<String, T>
}