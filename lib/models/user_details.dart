class UserDetails {

  String title;
  String name;

  UserDetails({this.title,this.name});

  UserDetails.fromJson(Map<String, dynamic> json)
      : title = json["user"]["title"], name = json["user"]["name"];
}