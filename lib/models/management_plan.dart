class ManagementPlan {
  String name;
  int id;

  ManagementPlan({this.id, this.name});

  ManagementPlan.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"];
}