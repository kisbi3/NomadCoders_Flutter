class WebtoonDetailModel {
  final String title, about, gnere, age;

  WebtoonDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        about = json['about'],
        gnere = json['genre'],
        age = json['age'];
}
