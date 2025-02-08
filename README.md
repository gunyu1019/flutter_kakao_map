# flutter_kakaomaps
![Pub Version](https://img.shields.io/pub/v/flutter_kakaomaps)
![Pub Monthly Downloads](https://img.shields.io/pub/dm/flutter_kakaomaps)
![Pub Points](https://img.shields.io/pub/points/flutter_kakaomaps)
![Pub Popularity](https://img.shields.io/pub/popularity/flutter_kakaomaps)

네이티브 기반의 [카카오맵](https://map.kakao.com/)을 구동할 수 있는 Flutter 플러그인입니다.

## 1. Getting Started
Flutter Kakao Maps 플러그인은 정식으로 배포되는 [Kakao Map SDK](https://apis.map.kakao.com/) 요구 조건을 따릅니다.
아래의 조건에 충족하는지 확인해주세요.

| Android                           | iOS (작업 중)  |
|-----------------------------------|----------------|
| * Android SDK 6.0(API lv.23) 이상 | * iOS 13 이상   |
| * `armeabi-v7a`, `arm64-v8a` 아키텍쳐 지원<br/>(`x86`, `x64` 아키텍쳐 지원하지 않습니다.) |        |
| * `OpenGL ES 2.0` 이상 지원               |         |
| * 인터넷 권한 설정 필요                    |         |

### 1-1. `pubspec.yml`에 패키지 를 추가합니다.
```yml
dependencies:
  flutter_kakaomaps: v0.1.0
```

### 1-2. Kakao Developers 네이티브 앱 키 추가
먼저 [카카오 개발자 사이트](https://developers.kakao.com/)에서 앱등록을 합니다.<br/>
앱 등록을 마치면, **네이티브 앱 키(App Key)** 를 발급받을 수 있습니다.

앱키는 아래와 같이 `KakaoMapSdk.instance.initialize` 함수를 호출하여 인증하실 수 있습니다.
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await KakaoMapSdk.instance.initialize('KAKAO_API_KEY');
  runApp( ... )
}
```

안드로이드에서는 키해시를 카카오 개발자 사이트에 등록해주셔서 추가인증해주셔야 합니다.<br/>
자세한 방법은 [플랫폼 등록](https://developers.kakao.com/docs/latest/ko/getting-started/app#platform-android)과 [키 해시](https://developers.kakao.com/docs/latest/ko/android/getting-started#before-you-begin-add-key-hash)을 참고해주세요.<br/>

Flutter Kakao Maps 플러그인은 디버깅, 릴리즈 해시키를 제공받을 수 있는 함수를 제공하고 있습니다.
```dart
await KakaoMapSdk.instance.hashKey();
```
안드로이드 한정된 기능으로 다른 플랫폼에서는 `null`을 반환합니다.

### 1-3. (안드로이드, 선택사항) 프로가드 규칙 설정
앱 배포시 Kakao Map SDK는 코드 축소, 난독화, 최적화 대상에서 제외해야 합니다.<br/>
`android > app > proguard-rules.pro` 파일을 아래와 같이 설정주십시요.
```pro
-keep class com.kakao.vectormap.** { *; }
-keep interface com.kakao.vectormap.**
```

## 2. MapView 위젯 추가
지도를 담고 있는 위젯(Widget)은 아래와 같이 호출하여 사용하실 수 있습니다.
```dart
Widget build(BuildContext context) {
  return Scaffold(
    body: KakaoMap(
      option: const KakaoMapOption(),
      onMapReady: (KakaoMapController controller) {
        print("카카오 지도가 정상적으로 불러와졌습니다.");
      },
    ),
  );
}
```
`KakaoMapOption` 매게변수에는 지도를 처음불러올 때 값을 설정해주실 수 있습니다.<br/>
`position`과 `zoomLevel` 인수는 지도를 불러오면 보여줄 좌표값과 확대/축소 비율입니다.<br/>
`mapType`은 지도의 유형입니다. 스카이뷰와 일반 지도 중 선택하여 사용자에게 제공할 수 있습니다.

아무 문제 없이 지도를 불러온다면, `onMapReady` 매개변수에 담긴 함수가 호출됩니다.<br/>
함수 매개변수에는 지도를 관리하기 위한 컨트롤러가 입력됩니다.

## 3. 지도 그리기
Flutter Kakao Maps는 정보를 사용자에게 표현하기 위한 다양한 그래픽 요소(오버레이 기능)를 제공하고 있습니다.<br/>
다양한 그래픽 요소는 `KakaoMapController`를 통해 제어하실 수 있습니다.
### 3-1. Poi (Label)
특정 위치에 정보를 제공하기 위한 이미지 또는 텍스트를 제공합니다.<br/>
Poi에는 사용하는 방법에 따라 3가지로 구분할 수 있습니다.<br/>

Poi의 사용방법은 카카오 SDK와 비슷합니다.<br/>
자세한 사용 방법은 [이곳](https://apis.map.kakao.com/android_v2/docs/api-guide/label/label/)을 참고해주세요.<br/>
Flutter Kakao Maps용 문서는 작성하는 중입니다.

* Poi: 특정 위치에 이미지나 텍스트로 정보를 표시 할 수 있습니다.
* Lod-Poi: LOD(Level of Detail)이 적용되어 한 번에 많은 양의 Poi를 지도에 표시할 수 있습니다. Lod-Poi에는 회전, 이동 기능이 없습니다.
* PolylineText: 선형으로 된 텍스트를 표현할 때 사용합니다.
  
```dart
// Poi
controller.labelLayer.addPoi(
  const LatLng(37.395763313860826, 127.11048591050786),
  style: PoiStyle(
    icon: KImage.fromAsset("assets/image/location.png", 68, 100),
  )
)

// Lod Poi
controller.lodLabelLayer.addLodPoi(
  const LatLng(37.395763313860826, 127.11048591050786),
  style: PoiStyle(
    icon: KImage.fromAsset("assets/image/location.png", 68, 100),
  )
)

// Polyline Text
// "보고있나? 카카오? ㅎ"라는 문구를 담고 있는 선형 텍스트를 만듭니다.
controller.labelLayer.addPolylineText(
  "보고있나? 카카오? ㅎ",
  const [
    LatLng(37.39375894087694, 127.10964757834647),
    LatLng(37.39623174904037, 127.10968366570474),
    LatLng(37.396289088551704, 127.1129315279461)
  ],
  style: PolylineTextStyle(28, Colors.blue)
);
```

### 3-2. Shape
지도에 선분이 담긴 도형을 제공합니다.<br/>
Kakao Map SDK에서 제공하는 도형은 두 가지가 있습니다.
* PolylineShape: 선형으로 된 도형입니다.
* PolygonShape: 선형 안에 내용물이 채워진 형태의 도형입니다.

도형을 구성하는 모델좌표계를 구성하는 방법은 2가지 형태가 있습니다.
* DotPoints: 특정 좌표(`LatLng`)을 기준으로 하여 상대 좌표를 이용하여 도형을 구성하는 방식
* MapPoints: 지도의 위도, 경도(`LatLng`)를 이용하여 좌표들의 꼭지점을 이어서 도형을 구성하는 방식

```
// DotPoints (RectanglePoint)를 이용하여 가로, 세로 300 크기의 선형(굵기: 10)이 있는 사각형
controller.shapeLayer.addPolylineShape(
  RectanglePoint(300, 300, const LatLng(37.396289088551704, 127.1129315279461)),
  PolylineStyle(Colors.green, 10.0),
  PolylineCap.round
);

// DotPoints (CirclePoint)를 이용하여 반지름이 200 크기인 원형
controller.shapeLayer.addPolygonShape(
  CirclePoint(200, const LatLng(37.39375894087694, 127.10964757834647)),
  PolygonStyle(Colors.green)
);
```

### 3-3. Route
지도에 다양한 선분이 담긴 길찾기 경로 모양의 도형을 제공합니다.

```dart
// 두께가 10이고, 색상은 노란색인 경로 도형을 그립니다.
controller.routeLayer.addRoute(const [
    LatLng(37.32428751919564, 127.10361027597592),
    LatLng(37.38433356340711, 127.10312961558715),
    LatLng(37.40049196436421, 127.09982509355939),
    LatLng(37.40605078821915, 127.09458697605862),
    LatLng(37.43918161748264, 127.06078195006104),
  ],
 RouteStyle(
    Colors.yellow, 10,
  )
);
```

`Route` 기능에는 일정 간격마다 이미지를 삽입하여 패턴 효과를 제공할 수 있습니다.
패턴 효과는 `RouteStyle`에 pattern 인수를 제공하여 이용할 수 있습니다.

```dart
// 6px 마다 원형의 도형의 패턴을 가지고 있는 스타일을 정의합니다.
RouteStyle.withPattern(
  RoutePattern(
    KImage.fromAsset("assets/image/circle.png", 30, 30), 6
  )
)
```

## 4. 기여 / 이슈 제보
Flutter Kakao Maps의 기여는 언제든지 환영합니다. <br/>
`Pull Reuqest` 해주시면, 확인 후 병합(`Merge`) 해드리겠습니다.

동일하게 버그 제보도 언제든지 환영합니다. 
문제가 발생하면 `Issue`를 열어주세요.