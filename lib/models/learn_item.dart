import 'learn_item_section.dart';

class LearnItem {

  final int id;

  final String title;
  final List<LearnItemSection> tools;
  final List<LearnItemSection> materials;
  final String summary;
  final String videoUrl;
  final String interval;

  LearnItem({
    this.id,
    this.title,
    this.summary,
    this.videoUrl,
    this.tools,
    this.materials,
    this.interval
  });

  LearnItem.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        summary = json["summary"],
        title = json["title"],
        videoUrl = json["video"],
        tools = json["tools"].map<LearnItemSection>((item) {return LearnItemSection.fromJson(item); } ).toList(),
        materials = json["materials"].map<LearnItemSection>((item) {return LearnItemSection.fromJson(item); } ).toList(),
        interval = json["interval"]["name"];
}