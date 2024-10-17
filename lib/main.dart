import 'package:flutter/material.dart';

void main() {
  // 아래 runApp은 import 'package:flutter/material.dart'; 에서 import 된 것임
  // void runApp(Widget app)
  // Widget이란? -> 레고 블럭
  // Widget들을 합치는 방식으로 앱을 만듦.
  // 앱의 UI를 만드는 레고 블럭
  runApp(App());
  // 모든 화면, 버튼 등등 모든 것들이 App이라는 이름을 갖는 Widget으로부터 올 것임.
  // 이 말은 즉 'App' Widget은 우리 앱의 root라는 것임.
}

// Widget으로 만들기 위해서는...?
// flutter SDK에 있는 3개의 core Widget중에 하나를 extends(상속)받아야 함.
// 여기서는 StatelessWidget을 상속받음.

// 모든 Widget은 build 메소드를 구현해야 함.
// build 메소드가 뭐임? -> Widget의 UI를 build(만드는) 것
class App extends StatelessWidget {
  // @override : 부모 class에 이미 있는 method를 override(덮어씌우는 것)
  // 부모 class에 있는 이미 있는 method 없애버림 -> 아래에 있는 함수로 대체
  @override
  // build도 Widget을 return해야 함.
  // build는 BuildContext 타입의 context라는 parameter를 받아옴. -> 일단 지금은 무시하자.
  Widget build(BuildContext context) {
    // 앱의 root Widget은 두 개의 옵션 중 하나를 return해야 함.(기본 UI 설정과 같은 재료를 선택해야 함.)
    // 1. MaterialApp -> 구글의 디자인 시스템
    // 2. CupertinoApp -> 애플의 디자인 시스템(iOS)
    // flutter는 구글꺼라서 보통 MaterialApp이 더 이쁘다고 한다...
    return MaterialApp(
      // flutter에는 scaffold가 있어야 한다는 규칙이 있음.
      // 이 앱의 홈에다가 scaffold를 넣자.
      home: Scaffold(
        // class 하나 쓸 때마다 comma를 적어주자. 그러면 VSCode가 이쁘게 정리해준다.
        appBar: AppBar(
          title: Text('Hello flutter!'),
        ),
        body: Center(
          child: Text('Hello world!'),
        ),
      ),
    );
  }
}
