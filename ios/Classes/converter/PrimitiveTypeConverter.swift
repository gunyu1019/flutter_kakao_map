internal func asBool(_ v: Any) -> Bool {
    v as! Bool
}

internal func asFloat(_ v: Any) -> Float {
    v as! Float
}

internal func asDouble(_ v: Any) -> Double {
    v as! Double
}

internal func asInt(_ v: Any) -> Int {
    v as! Int
}

internal func asString(_ v: Any) -> String {
    v as! String
}

internal func asDict(_ v: Any) -> Dictionary<String, Any> {
    v as! Dictionary<String, Any>
}

internal func castSafty<T>(_ v: Any?, caster: (Any) throws -> T) -> T? {
    if v == nil {
        return nil
    } else {
        return try! caster(v!)
    }
}
