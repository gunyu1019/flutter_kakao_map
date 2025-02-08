internal protocol KakaoMapControllerSender {
    func onMapReady()

    func onMapDestroy()

    func onMapResumed()

    func onMapPaused()

    func onMapError(error: Error)
}