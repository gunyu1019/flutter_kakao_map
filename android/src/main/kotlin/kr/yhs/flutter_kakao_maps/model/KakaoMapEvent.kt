package kr.yhs.flutter_kakao_maps.model

enum class KakaoMapEvent(val id: Int) {
    CameraMoveStart(1),
    CameraMoveEnd(2);
    
    fun compare(other: Int): Boolean { 
        return (this.id and other) == this.id;
    }
}