class ListDataModel {
  int? id;
  String? title;
  String? slug;
  String? image;

  ListDataModel({
    this.id,
    this.title,
    this.slug,
    this.image,
  });

  factory ListDataModel.fromJson(Map<String, dynamic> json) => ListDataModel(
        id: json["id"],
        title: json["title"] ?? "",
        slug: json["slug"] ?? "",
        image: json["image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "image": image,
      };
}
