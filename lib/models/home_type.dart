class HomeType {
  String name;
  int id;

  HomeType({this.id, this.name});

  HomeType.fromJson(Map<String, dynamic> json)
      : id = json["id"],
      name = json["name"];
}