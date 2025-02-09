## 0.1.0-dev.5
* First Deploy

## 0.2.0-dev.1
* Implement Kakao Map View to iOS Platform
  * Kakao Map Lifecycle in native environment
  * Support responsive frame
  * Split delegate instance to `KakaoMapViewDelegate.swift`
* Implement Kakao Map Plugin in iOS Platform (based cocoapod)
  * Implement converter (PrimitiveTypeConverter, CameraTypeConverter) with extension and internal function.
  * Implement `MapviewType` object to setup kakao map with extension.
* Implement some feature in Kakao Map Controller
  * `moveCamera` method to control camera looking at a kakao map.
  * `getCameraPosition` method to get camera position looking at a kakao map.
* Implement `SDKInitializer` class in iOS Platform