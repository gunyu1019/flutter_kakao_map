## 0.2.0-dev.3
* Support all feature related Poi in iOS Platform.
  * Add and remove LodPoi or LodLabelLayer
  * Add and remove PolylineText
  * Modify Poi.
  * Implement Label Converter (WaveTextStyle, WaveTextOption)
* [Fix] Missing feature autoMove parameter in Poi.show() method
* [Fix] Missing feature transition parameter in Poi.changestyle(), Poi.changeText() method

## 0.2.0-dev.2
* Support some feature related Poi in iOS Platform.
  * Add and remove Poi or LabelLayer.
  * Implement Label Converter(PoiTextStyle, PoiIconStyle, PoiOptions ... etc).
* Add `setGestureEnable` method in iOS Platform.
* Implement `onCameraMoveStart` and `onCameraMoveEnd` event handler.
* Implement Reference Converter(UIColor, UIImage) to cast swift instance from dart instance.
* Configure `buildingHeightScale` property to not be required awaitable.
* Apply MapGravity at Poi.textGravity property.
* Rename default view name on iOS Platform for integration Android default view name
* [Fix] Invaild raw value in MapGravity enumeration
* [Fix] Invaild keyword in transition from enterence to entrance
* [Fix] Adjust default aspectRatio property in PoiTextStyle
* [Fix] Adjust default clickable parameter in LabelController.addPoi and LodLabelController.addLodPoi.

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

## 0.1.0-dev.5
* Initial Deployment (Implement Kakao Map to Android Platform)