internal protocol BaseError: Error {
    var errorCode: Int64 { get };
    var message: String? { get };
}