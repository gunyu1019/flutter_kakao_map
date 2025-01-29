# flutter_kakao_maps
![Pub Version](https://img.shields.io/pub/v/flutter_kakao_maps)
![Pub Monthly Downloads](https://img.shields.io/pub/dm/flutter_kakao_maps)
![Pub Points](https://img.shields.io/pub/points/flutter_kakao_maps)
![Pub Popularity](https://img.shields.io/pub/popularity/flutter_kakao_maps)

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
  flutter_kakao_maps: v0.1.0
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