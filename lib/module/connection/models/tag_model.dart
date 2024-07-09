class Tag {
  int? id;
  int? postId;
  String? tag;
  DateTime? createdAt;
  DateTime? updatedAt;

  Tag({
    this.id,
    this.postId,
    this.tag,
    this.createdAt,
    this.updatedAt,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    id: json["id"],
    postId: json["post_id"],
    tag: json["tag"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "post_id": postId,
    "tag": tag,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}