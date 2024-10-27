import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

// 위젯 그 자체
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

// state: 위젯에 들어갈 데이터와 UI를 넣는 곳
class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.red,
          ),
        ),
      ),
      home: const Scaffold(
        backgroundColor: Color(0xFFF4EDDB),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyLargeTitle(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyLargeTitle extends StatelessWidget {
  const MyLargeTitle({
    super.key,
  });

  @override
  // context: 모든 부모 요소들에 대한 정보
  // 위젯 트리 안에서 위젯의 위치를 다룸.
  // 위젯 트리에서 위젯의 위치를 제공하고, 이를 통해 상위 요소 데이터에 접근 가능.
  Widget build(BuildContext context) {
    return Text(
      'My Large Title',
      style: TextStyle(
          // ! : null이 아니라고 강력하게 확신한다는 의미.
          // ? : null이 아니라면 사용하라는 의미.
          fontSize: 30,
          color: Theme.of(context).textTheme.titleLarge!.color),
    );
  }
}
