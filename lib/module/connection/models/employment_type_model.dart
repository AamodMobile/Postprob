class EmploymentType {
  int? id;
  String? title;
  String? slug;
  dynamic createdAt;
  dynamic updatedAt;
  int? deletedAt;

  EmploymentType({
    this.id,
    this.title,
    this.slug,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory EmploymentType.fromJson(Map<String, dynamic> json) => EmploymentType(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
  };
}