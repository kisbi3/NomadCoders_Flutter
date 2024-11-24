// package를 찾아보려면 pub.dev에서 찾아보자.
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  final String today = "today";

  void getTodaysToons() async {
    // 그냥 http.dart 불러오면 get.url()이렇게 불러오면 되는데, 확실히 하기 위해서
    // http로 namespace를 정해서 http.get()으로 불러옴.

    final url = Uri.parse('$baseUrl/$today');

    // get의 반환값이 Future임.
    // Future : 미래에 받을 값의 타입을 알려줌.
    // 아래의 요청이 마무리 될 때까지 이후의 코드가 진행되면 안됨. -> async programming
    // await을 통해서 기다리게 할 수 있음.
    // await을 사용하려면 'async'함수 내에서만 사용할 수 있음.
    // 보통 Future를 반환할 때에 사용함.
    // Future<Respons> : 나중에 Response를 반환할 것이라는 의미.
    final response = await http.get(url);

    // 200은 성공했다는 뜻.
    if (response.statusCode == 200) {
      print(response.body);
      return;
    }
    throw Error();
  }
}
