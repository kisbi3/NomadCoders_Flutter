import 'package:flutter/material.dart';
// Timer 가져오기
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 25분을 입력하는 것에 대해서 실수하지 않기 위해서 상수를 만들어 버리자.
  static const twentyFiveMinutes = 1500;
  int totalSeconds = twentyFiveMinutes;
  // 사용자가 버튼을 누를 때만 타이머가 생성되게 할 예정이라 late로 초기화를 미루자.
  late Timer timer;
  // 일시정지 버튼을 만들기 위함.
  bool isRunning = false;
  // Pomodoro 횟수 세는 변수
  int totalPomodoros = 0;

  void onTick(Timer timer) {
    // 0초가 되면...
    if (totalSeconds == 0) {
      // Pomodoro 숫자 증가 + 초기화
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        isRunning = false;
        totalSeconds = twentyFiveMinutes;
      });
      timer.cancel();
    } else {
      // state 변경
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  void onStartPressed() {
    // Timer -> 정해진 간격에 한번씩 함수 실행
    // 1초마다 onTick 함수 실행
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    setState(() {
      isRunning = true;
    });
  }

  // 시간 멈추게 하기
  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  // 초를 (분 : 초) 로 나오도록 변경하는 함수.
  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          // Flexible
          // 하드 코딩되는 값을 만들게 해줌(?)
          // 높이 200, 너비 100픽셀 -> UI에 기반해서 더 유연하게 만들 수 있게 해줌.
          // 하나의 박스가 얼마나 공간을 차지할 지 '비율'을 정할 수 있다.
          Flexible(
            // flex의 기본값은 1임
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: IconButton(
                iconSize: 120,
                color: Theme.of(context).cardColor,
                onPressed: isRunning ? onPausePressed : onStartPressed,
                icon: Icon(isRunning
                    ? Icons.pause_circle_outline
                    : Icons.play_circle_outline),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodoros',
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .color,
                          ),
                        ),
                        Text(
                          '$totalPomodoros',
                          style: TextStyle(
                            fontSize: 58,
                            color: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
