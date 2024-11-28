import 'package:flutter/material.dart';
import 'package:toonflix/screens/home_screen.dart';
import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..userAgent =
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36';
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();

  runApp(const App());
}

class App extends StatelessWidget {
  // 이 위젯의 key를 stateless widget이라는 슈퍼클래스에 보낸 것임.
  const App({super.key});

  // 위젯은 ID같은 식별자 역할을 하는 key가 있다.
  // 이걸로 Flutter가 위젯을 빠르게 찾는 것임.
  // 사실 상관 없음.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
