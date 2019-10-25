class MobilityIssue {
  String name;
  int id;

  MobilityIssue({this.id, this.name});

  MobilityIssue.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"];
}