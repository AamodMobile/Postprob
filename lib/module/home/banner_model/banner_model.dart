class BannerModel {
  int? id;
  String? title;
  String? banner;
  int? status;

  BannerModel({
    this.id,
    this.title,
    this.banner,
    this.status,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    id: json["id"],
    title: json["title"],
    banner: json["banner"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "banner": banner,
    "status": status,
  };
}