class MaintenanceItem {

  final int id;
  final int sectionId;
  final int featuredImageId;
  final int intervalId;
  final int weatherTriggerTypeId;
  final String title;
  final int points;
  final int mobilityPriority;
  final String summary;
  final String cautions;
  final String createdAt;

  MaintenanceItem({
    this.id,
    this.sectionId,
    this.featuredImageId,
    this.intervalId,
    this.weatherTriggerTypeId,
    this.title,
    this.points,
    this.mobilityPriority,
    this.summary,
    this.cautions,
    this.createdAt});

  MaintenanceItem.fromJson(Map<String, dynamic> json)
    : id = json["id"],
      sectionId = json["section_id"],
      featuredImageId = json["featured_image_id"],
      intervalId = json["interval_id"],
      weatherTriggerTypeId = json["weather_trigger_type_id"],
      title = json["title"],
      points = json["points"],
      mobilityPriority = json["mobility_priority"],
      summary = json["summary"],
      cautions = json["cautions"],
      createdAt = json["created_at"];

}