class WebtoonModel {
  final String title, thumb, id;

  // fromJson named constructor -> map을 받을 것임.
  // json 값으로 initialize
  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}
