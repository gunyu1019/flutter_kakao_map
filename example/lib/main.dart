import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_kakao_map/flutter_kakao_map.dart';

void main() async {
  await dotenv.load(fileName: 'assets/config/.env');
  KakaoMapSdk.instance.initialize(dotenv.env['KAKAO_API_KEY']!);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:  SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: KakaoMap(),
      ),
    );
  }
}
