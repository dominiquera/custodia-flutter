class User {
  int id;

  User({this.id});

  User.fromJson(Map<String, dynamic> json)
      : id = json["id"];
}