internal struct AuthenticatedFailed : BaseError {
    var errorCode: Int64
    var message: String?

    init (errorCode: Int64, message: String) {
        self.errorCode = errorCode
        self.message = message
    }
}