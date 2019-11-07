class LearnItemSection  {

  final int id;
  final String value;

  LearnItemSection({
    this.id,
    this.value,
  });

  LearnItemSection.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        value = json["value"];
}