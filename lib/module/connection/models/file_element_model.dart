class FileElement {
  int? id;
  int? postId;
  String? file;
  String? fileType;
  DateTime? createdAt;
  DateTime? updatedAt;

  FileElement({
    this.id,
    this.postId,
    this.file,
    this.fileType,
    this.createdAt,
    this.updatedAt,
  });

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
    id: json["id"],
    postId: json["post_id"],
    file: json["file"],
    fileType: json["file_type"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "post_id": postId,
    "file": file,
    "file_type": fileType,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}