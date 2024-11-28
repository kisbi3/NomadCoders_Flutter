import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // 6.5 waitForWebToons를 대체할 방법은?
  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //그림자를 줄일 수 있음
        elevation: 2,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black,
        foregroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          "오늘의 웹툰",
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          // snapshot을 이용해서 Future의 상태를 알 수 있음.
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(child: makeList(snapshot)),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    // 많은 양의 데이터를 연속적으로 보여주고 싶을 때 ListView 사용(나열)
    // ListView.builder는 ListView를 최적화 한 것이다.
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      // padding 안주면 그림자 위쪽이 짤림
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      // ListView의 아이템을 만드는 역할
      itemBuilder: (context, index) {
        // 0, 1, 2같은 index로만 접근 가능.
        var webtoon = snapshot.data![index];
        return Column(
          children: [
            Container(
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
              child: Image.network(webtoon.thumb),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              webtoon.title,
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 40),
    );
  }
}
