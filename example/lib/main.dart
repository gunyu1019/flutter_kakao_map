import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_debug_overlay/flutter_debug_overlay.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_kakao_map/flutter_kakao_map.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: 'assets/config/.env');
  await KakaoMapSdk.instance.initialize(dotenv.env['KAKAO_API_KEY']!);

  
    
  DebugOverlay.enabled = true;

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
  String status = "Not Loaded";
  bool load = false;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
        fontSize: 14.0, color: Colors.blue, decoration: TextDecoration.none);
    var mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var screenHeight = mediaQueryData.size.height;

    return MaterialApp(
      builder: DebugOverlay.builder(
        logBucket: MyApp.logBucket
      ),
      home: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(10.0)),
            FutureBuilder(
                future: KakaoMapSdk.instance.hashKey(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return (snapshot.hasData
                      ? Text(snapshot.data ?? "로딩 실패", style: textStyle)
                      : const Text("로딩 중", style: textStyle));
                }),
            Row(
              children: [
                Checkbox(
                    value: load,
                    onChanged: (v) {
                      setState(() {
                        load = v!;
                      });
                    }),
                Text("Status: $status", style: textStyle),
              ],
            ),
            SizedBox(
                width: screenWidth,
                height: screenHeight * 0.9,
                child: load ? KakaoMap(onMapReady: onMapReady) : null)
          ],
        ),
      ),
    );
  }

  void onMapReady(KakaoMapController controller) {
    controller = controller;
  }
}
