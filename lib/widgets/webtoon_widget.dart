import 'package:flutter/material.dart';
import 'package:toonflix/screens/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;

  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap = onTapDown + onTapUp
      //       = 누르기 + 띄기
      onTap: () {
        // Navigator 화면을 바꿀 때 사용
        // Navigator.push(context, route)
        // route : 애니메이션 효과로 감싸서 스크린 처럼 보이게 한다.
        // MaterialPageRoute : StatelessWidget을 route로 감싸서 다른 스크린 처럼 보이게 함.
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = const Offset(1.0, 0.0);
              var end = Offset.zero;
              var curve = Curves.ease;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            pageBuilder: (context, anmation, secondaryAnimation) =>
                DetailScreen(id: id, title: title, thumb: thumb),
          ),
        );
      },
      child: Column(
        children: [
          // Hero는 썸네일만 감싸고 있음!
          Hero(
            tag: id,
            child: Container(
              width: 250,
              // clipbehavior를 적용해야 둥근 모서리가 적용이 된다.
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                // 그림자 관련 옵션
                boxShadow: [
                  BoxShadow(
                    // blurRadius : 그림자 크기
                    blurRadius: 15,
                    // offset : 그림자 위치
                    offset: const Offset(10, 10),
                    // color : 그림자 색
                    color: Colors.black.withOpacity(0.5),
                  )
                ],
              ),
              child: Image.network(thumb),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
