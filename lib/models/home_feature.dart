class HomeFeature {
  String name;
  int id;

  HomeFeature({this.id, this.name});

  HomeFeature.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"];
}