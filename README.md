# flutter_kakao_map
네이티브 환경 기반의 카카오맵을 구현하는 플러그인입니다. 
현재 작업 중인 프로젝트이며, 빠른 시일 내에 완성시킬 예정입니다.

아래의 내용은 임시로 작성된 문서이며 작업이 완료된 후에는 재작성될 예정입니다.

**<Available Features>**
* KakaoMap Widget
* Move camera position.
* Handle moving camera position event.
* Add Overlay
    * Poi
    * Lod-Poi
    * Polyline Text
    * Polyline Shape
    * Polyline Shape
    * (WIP, Not-yet) Route Line (#6)

### 지도 위젯

`KakaoMapSdk` 인스턴스를 통해 카카오맵 API 키를 넣어주셔야 합니다.
키는 [Kakao Developers](https://developers.kakao.com/)에서 발급하여 네이티브 키를 입력하시면 됩니다.

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await KakaoMapSdk.instance.initialize("네이티브 키");

  // 안드로이드 환경에서는 Hash Key를 요구합니다.
  // Hash Key는 아래의 메소드를 이용하여 불러올 수 있습니다.
  // 다른 환경에서는 null을 반환합니다.
  final hashKey = await KakaoMapSdk.instance.hashKey()
}
```

`StatefulWidget` 기반의 `KakaoMap` 클래스를 불러오면 됩니다.
지도가 정상적으로 불러와진다면, `onMapReady` 매개변수가 호출됩니다.<br/>
`option` 매개변수는 처음 불러올 지도의 옵션을 설정합니다.<br/>

```dart
KakaoMap(
  void Function(KakaoMapController controller) onMapReady,
  KakaoMapOption? option,
  bool forceGesture = true,
  KakaoMapLifecycle? onMapLifecycle,
  void Function(GestureType gestureType)? onCameraMoveStart
  void Function(CameraPosition position, GestureType gestureType)? onCameraMoveEnd,
  void Function(Exception exception)? onMapError
)
```

### 카메라 이동
카메라 이동은 KakaoMapController를 통해 이동할 수 있습니다.
`animation` 매개변수를 통해 카메라 이동에 애니메이션 효과를 줄 수 있습니다.
```dart
await controller.moveCamera(
  CameraUpdate.newCenterPosition(const LatLng(
    37.395763313860826, 127.11048591050786)),
  animation: const CameraAnimation(5000)
);
```

### 오버레이 구현
오버레이 구현은 작업 중에 있습니다. 

#### Poi / Label
Poi는 특정 지점의 정보를 표시하는 용도로 사용됩니다.
```dart
final poiStyle = PoiStyle(
    id: "poi_StyleId"
    icon: KImage.fromAssets("ICON ASSET"),
    textStyle: const [PoiTextStyle(size: 28, color: Colors.black)]
)
await controller.labelLayer.addPoi(
    const LatLng(37.395763313860826, 127.11048591050786),
    text: "Project FKMP(Flutter Kakao-Map Plugin)"
    style: poiStyle
)
```

### Polyline Shape / Polygon Shape
(작업 중) Polygon Shape와 Polyline Shape는 다양한 선분이 있는 도형을 지도에 표시하는 용도로 사용됩니다.

```dart
final polygonStyle = PolygonStyle(
  id: "polygon_StyleId",
  color: Colors.blue
)
final polygon = PolygonMultipleShape.withAbsolute(
  MapPoints([
    const LatLng(37.395763313860826, 127.11048591050786),
    ...
  ]),
  style=polygonStyle
)
polygon.addPolygon(
  DotPoints.circle​(const LatLng(37.395763313860826, 127.11048591050786), 10.0)
  style=polygonStyle,
)
await controller.shapeLayer.addMultiplePolygonShape(polygon)
```
