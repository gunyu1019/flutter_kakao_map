import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_kakao_map/flutter_kakao_map.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await dotenv.load(fileName: 'assets/config/.env');
  await KakaoMapSdk.instance.initialize(dotenv.env['KAKAO_API_KEY']!);

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
    const textStyle = TextStyle(fontSize: 10.0);

    return MaterialApp(
      home: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            FutureBuilder(future: KakaoMapSdk.instance.hashKey(), builder: (BuildContext context, AsyncSnapshot snapshot) {
              return (
                snapshot.hasData ?
                Text(snapshot.data ?? "로딩 실패", style: textStyle) :
                const Text("로딩 중", style: textStyle)
              );
            }),
            const KakaoMap()
          ],
        ),
      ),
    );
  }
}
