class Score {

  final int value;

  Score({this.value});

  Score.fromJson(Map<String, dynamic> json)
      : value = json["score"];
}