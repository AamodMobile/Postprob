import 'package:postprob/module/connection/models/category_model.dart';
import 'package:postprob/module/connection/models/city_model.dart';
import 'package:postprob/module/connection/models/employment_type_model.dart';
import 'package:postprob/module/connection/models/file_element_model.dart';
import 'package:postprob/module/connection/models/tag_model.dart';
import 'package:postprob/module/login/model/user_model.dart';

class PostDetailsModel {
  int? id;
  String? title;
  dynamic company;
  String? slug;
  String? position;
  EmploymentType? employmentType;
  String? description;
  String? categoryId;
  String? workplaceId;
  String? cityId;
  int? isApplied;
  int? isSaved;
  dynamic image;
  dynamic shareCount;
  String? postedByUserid;
  dynamic updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? deletedAt;
  String? postedAt;
  Category? category;
  Category? workplace;
  City? city;
  User? user;
  List<FileElement>? files;
  List<Tag>? tags;

  PostDetailsModel({
    this.id,
    this.title,
    this.company,
    this.slug,
    this.position,
    this.employmentType,
    this.description,
    this.categoryId,
    this.workplaceId,
    this.cityId,
    this.isApplied,
    this.isSaved,
    this.image,
    this.postedByUserid,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.postedAt,
    this.category,
    this.workplace,
    this.city,
    this.user,
    this.files,
    this.tags,
    this.shareCount,
  });

  factory PostDetailsModel.fromJson(Map<String, dynamic> json) => PostDetailsModel(
        id: json["id"],
        title: json["title"],
        company: json["company"],
        slug: json["slug"],
        position: json["position"],
        employmentType: json["employment_type"] == null ? null : EmploymentType.fromJson(json["employment_type"]),
        description: json["description"],
        categoryId: json["category_id"],
        workplaceId: json["workplace_id"],
        cityId: json["city_id"],
        isApplied: json["is_applied"],
        isSaved: json["is_saved"],
    shareCount: json["share_count"],
        image: json["image"],
        postedByUserid: json["posted_by_userid"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        postedAt: json["posted_at"],
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
        workplace: json["workplace"] == null ? null : Category.fromJson(json["workplace"]),
        city: json["city"] == null ? null : City.fromJson(json["city"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        files: json["files"] == null ? [] : List<FileElement>.from(json["files"]!.map((x) => FileElement.fromJson(x))),
        tags: json["tags"] == null ? [] : List<Tag>.from(json["tags"]!.map((x) => Tag.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "company": company,
        "slug": slug,
        "position": position,
        "employment_type": employmentType?.toJson(),
        "description": description,
        "category_id": categoryId,
        "workplace_id": workplaceId,
        "city_id": cityId,
        "is_applied": isApplied,
        "is_saved": isSaved,
    "share_count": shareCount,
        "image": image,
        "posted_by_userid": postedByUserid,
        "updated_by": updatedBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "posted_at": postedAt,
        "category": category?.toJson(),
        "workplace": workplace?.toJson(),
        "city": city?.toJson(),
        "user": user?.toJson(),
        "files": files == null ? [] : List<dynamic>.from(files!.map((x) => x.toJson())),
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x.toJson())),
      };
}
