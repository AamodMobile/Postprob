class CitiesModel {
  int? id;
  String? city;
  int? stateId;
  String? title;

  CitiesModel({
    this.id,
    this.city,
    this.stateId,
    this.title,
  });

  factory CitiesModel.fromJson(Map<String, dynamic> json) => CitiesModel(
    id: json["id"],
    city: json["city"],
    stateId: json["state_id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "city": city,
    "state_id": stateId,
    "title": title,
  };
}
