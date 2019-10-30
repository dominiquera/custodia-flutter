class Score {

   int value;

  Score({this.value});

  Score.fromJson(Map<String, dynamic> json)
  {
    if (json["score"] < 0) {
      this.value = 0;
    } else {
      this.value = json["score"];
    }
  }
}