class DrivewayType {
  String name;
  int id;

  DrivewayType({this.id, this.name});

  DrivewayType.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"];
}