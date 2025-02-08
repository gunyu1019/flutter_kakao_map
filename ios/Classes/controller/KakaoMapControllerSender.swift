import KakaoMapsSDK

internal protocol KakaoMapControllerSender {
    func onMapReady(kakaoMap: KakaoMap)

    func onMapDestroy()

    func onMapResumed()

    func onMapPaused()

    func onMapError(error: Error)
}