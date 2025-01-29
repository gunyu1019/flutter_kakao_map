import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_debug_overlay/flutter_debug_overlay.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_kakao_maps/flutter_kakao_maps.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: 'assets/config/.env');
  await KakaoMapSdk.instance.initialize(dotenv.env['KAKAO_API_KEY']!);

  DebugOverlay.enabled = true;

  final hashKey = await KakaoMapSdk.instance.hashKey();
  MyApp.logBucket.add(LogEvent(
    level: LogLevel.info,
    message: "HashKey( $hashKey ) to add Kakao Developers.",
  ));

  // Uncaught Exceptions.
  PlatformDispatcher.instance.onError = (exception, stackTrace) {
    MyApp.logBucket.add(LogEvent(
      level: LogLevel.fatal,
      message: "Unhandled Exception",
      error: exception,
      stackTrace: stackTrace,
    ));
    return false;
  };

  // Rendering Exceptions.
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    MyApp.logBucket.add(LogEvent(
      level: LogLevel.fatal,
      message: details.exceptionAsString(),
      error: details.toDiagnosticsNode().toStringDeep(),
      stackTrace: details.stack,
    ));
  };

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static final LogBucket logBucket = LogBucket();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late KakaoMapController controller;
  LatLng? position;
  List<bool> isSelected = [false, false];

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
        fontSize: 14.0, color: Colors.blue, decoration: TextDecoration.none);
    var mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var screenHeight = mediaQueryData.size.height;

    return MaterialApp(
        builder: DebugOverlay.builder(logBucket: MyApp.logBucket),
        home: Scaffold(
          body: SizedBox(
            width: screenWidth,
            height: screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                SizedBox(
                    width: screenWidth,
                    height: screenHeight * 0.8,
                    child: KakaoMap(
                        onMapReady: onMapReady,
                        onMapError: onMapError,
                        onCameraMoveEnd: (position, gestureType) => {
                              setState(() {
                                this.position = position.position;
                              })
                            })),
                Text("경도: ${position?.latitude}, 위도: ${position?.longitude}",
                    style: textStyle),
                ToggleButtons(
                    isSelected: isSelected,
                    onPressed: (int index) {
                      setState(() {
                        for (int buttonIndex = 0;
                            buttonIndex < isSelected.length;
                            buttonIndex++) {
                          if (buttonIndex == index) {
                            isSelected[buttonIndex] = true;
                          } else {
                            isSelected[buttonIndex] = false;
                          }
                        }

                        switch (index) {
                          case 1:
                            controller.moveCamera(
                                CameraUpdate.newCenterPosition(const LatLng(
                                    37.395763313860826, 127.11048591050786)),
                                animation: const CameraAnimation(5000));
                            break;
                          case 0:
                            controller.moveCamera(
                                CameraUpdate.newCenterPosition(
                                    const LatLng(37.867489, 127.745273)),
                                animation: const CameraAnimation(5000));
                            break;
                        }
                      });
                    },
                    children: const <Widget>[
                      Text("강원대학교"),
                      Text("판교아지트"),
                    ])
              ],
            ),
          ),
        ));
  }

  void onMapReady(KakaoMapController controller) {
    this.controller = controller;
    MyApp.logBucket.add(LogEvent(
      level: LogLevel.info,
      message: "KakaoMap.onMapReay called!",
    ));
    controller.getCameraPosition().then((result) {
      setState(() {
        position = result.position;
      });
    });

    controller.lodLabelLayer.addLodPoi(
        const LatLng(37.395763313860826, 127.11048591050786),
        text: "KAKAO LABEL",
        style: PoiStyle(
              icon: KImage.fromAsset("assets/image/location.png", 68, 100),
              anchor: const KPoint(0.5, 0.9),
              textStyle: const [PoiTextStyle(size: 28, color: Colors.blue, stroke: 2, strokeColor: Colors.white)])
        ).then((poi) => poi.changeText("KAKAO MAP LABEL"));

    controller.labelLayer.addPolylineText(
        "휘어지는 글씨 테스트",
        const [
          LatLng(37.39375894087694, 127.10964757834647),
          LatLng(37.39623174904037, 127.10968366570474),
          LatLng(37.396289088551704, 127.1129315279461)
        ],
        style: PolylineTextStyle(28, Colors.blue)
    );

    controller.shapeLayer.addPolylineShape(
      RectanglePoint(100, 100, const LatLng(37.396289088551704, 127.1129315279461)),
      PolylineStyle(Colors.green, 10.0),
      PolylineCap.round
    );

    controller.shapeLayer.addPolygonShape(
      CirclePoint(200, const LatLng(37.39375894087694, 127.10964757834647)),
      PolygonStyle(Colors.green)
    );

    controller.routeLayer.addRoute(const [
      LatLng(37.32428751919564, 127.10361027597592),
      LatLng(37.38433356340711, 127.10312961558715),
      LatLng(37.40049196436421, 127.09982509355939),
      LatLng(37.40605078821915, 127.09458697605862),
      LatLng(37.43918161748264, 127.06078195006104),
    ], RouteStyle(Colors.black, 10, pattern: RoutePattern(KImage.fromAsset("assets/image/circle.png", 30, 30), 6)));
  }

  void onMapError(Exception exception) {
    MyApp.logBucket.add(LogEvent(
      level: LogLevel.fatal,
      message: "KakaoMap.onMapError caused!",
      error: exception,
    ));
  }
}
