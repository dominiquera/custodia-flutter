class OutdoorSpace {
  String name;
  int id;

  OutdoorSpace({this.id, this.name});

  OutdoorSpace.fromJson(Map<String, dynamic> json)
      : id = json["id"],
      name = json["name"];
}