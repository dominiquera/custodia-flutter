class UserDetails {

  String title;
  String name;
  String subtitle;
  String outside;
  String inside;
  UserDetails({this.title,this.name,this.subtitle,this.outside,this.inside});

  UserDetails.fromJson(Map<String, dynamic> json)
      : title = json["user"]["title"], name = json["user"]["name"], subtitle = json["user"]["subtitle"]
  , outside = json["user"]["outside"], inside = json["user"]["inside"];
}