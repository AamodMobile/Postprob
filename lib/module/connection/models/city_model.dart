class City {
  int? id;
  String? city;
  int? stateId;
  String? title;

  City({
    this.id,
    this.city,
    this.stateId,
    this.title,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
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