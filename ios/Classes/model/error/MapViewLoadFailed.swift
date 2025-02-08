internal struct MapViewLoadFailed : BaseError {
    var errorCode: Int64 = 0
    var message: String? = "Map Engine creation or initialization failed."
}