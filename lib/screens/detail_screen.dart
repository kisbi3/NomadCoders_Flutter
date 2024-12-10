import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/models/webtoon_epsiode_model.dart';
import 'package:toonflix/widgets/episode_widget.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  // 아래와 같이 StatelessWidget 상태에서 home_screen.dart처럼은 불가능하다.
  // Future<WebtoonDetailModel> webtoon = ApiService.getToonById(id);
  // webtoon property를 초기화 할 때에 다른 property인 id에 접근이 불가능하기 때문.
  // final String title, thumb, id;
  // 이 부분은 class의 member들을 정의하고 초기화 하는 것이 끝이기 때문임.
  // ''' 어떤 property를 초기화 할 때에 다른 properety로는 접근이 불가능함.
  // 해결방법은 다음과 같음
  // 1. StatelessWidget -> StatefulWdiget

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;
  late SharedPreferences prefs;
  bool isLiked = false;

  // 좋아요 누른 웹툰 id 리스트 initialize
  Future initPrefs() async {
    // getInstace가 Future임.
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList('likedToons');
    // getStringList를 통해서 얻은 likedToons는 null값이 가능하기 때문에 null값인지 아닌지 확인해야 함.
    if (likedToons != null) {
      // List에서 현재 detail_screen의 웹툰이 좋아요가 체크 되어 있는지 확인
      if (likedToons.contains(widget.id) == true) {
        // setState를 통해서 UI를 Refresh 해야 함!
        setState(() {
          isLiked = true;
        });
      }
    } else {
      // 앱이 처음 실행될 경우에만 실행 됨.
      await prefs.setStringList('likedToons', []);
    }
  }

  // 좋아요 버튼 누르면 실행하는 함수
  onHeartTap() async {
    final likedToons = prefs.getStringList('likedToons');
    if (likedToons != null) {
      if (isLiked) {
        likedToons.remove(widget.id);
      } else {
        likedToons.add(widget.id);
      }
      // likedToons라는 이름의 리스트 저장
      await prefs.setStringList('likedToons', likedToons);
      setState(() {
        // isLiked의 반대 값을 넣어줌
        isLiked = !isLiked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getLatestEpisodesById(widget.id);
    initPrefs();
  }

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
        actions: [
          IconButton(
            onPressed: onHeartTap,
            icon: Icon(isLiked ? Icons.favorite : Icons.favorite_outline),
          ),
        ],
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.id,
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
                      child: Image.network(widget.thumb),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              FutureBuilder(
                future: webtoon,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.about,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          '${snapshot.data!.gnere} / ${snapshot.data!.age}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    );
                  }
                  return const Text("...");
                },
              ),
              const SizedBox(
                height: 25,
              ),
              FutureBuilder(
                future: episodes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // 출력해야 하는 개수가 적을 때에는 ListView, ListView.builder보다 Column으로 표시하는게 더 편함.
                    return Column(
                      children: [
                        for (var episode in snapshot.data!)
                          Episode(episode: episode, webtoonId: widget.id),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
