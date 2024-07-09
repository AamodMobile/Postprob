class LevelListModel {
  int? id;
  String? title;
  String? slug;

  LevelListModel({
    this.id,
    this.title,
    this.slug,
  });

  factory LevelListModel.fromJson(Map<String, dynamic> json) => LevelListModel(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
  };
}
