class ListDataModel {
  int? id;
  String? title;
  String? slug;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? deletedAt;

  ListDataModel({
    this.id,
    this.title,
    this.slug,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory ListDataModel.fromJson(Map<String, dynamic> json) => ListDataModel(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
