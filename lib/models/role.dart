class Role {
  int id;

  Role({this.id});

  Role.fromJson(Map<String, dynamic> json)
      : id = json["id"];
}