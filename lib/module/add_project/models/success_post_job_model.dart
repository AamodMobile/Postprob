

import 'package:postprob/module/add_project/models/cities_model.dart';
import 'package:postprob/module/connection/models/category_model.dart';
import 'package:postprob/module/connection/models/employment_type_model.dart';
import 'package:postprob/module/connection/models/file_element_model.dart';
import 'package:postprob/module/login/model/user_model.dart';

class SuccessPostJobModel {
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
  dynamic image;
  int? shareCount;
  String? postedByUserid;
  dynamic updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? deletedAt;
  Category? category;
  Category? workplace;
  CitiesModel? city;
  User? user;
  List<FileElement>? files;
  SuccessPostJobModel({
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
    this.image,
    this.shareCount,
    this.postedByUserid,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.category,
    this.workplace,
    this.city,
    this.user,
    this.files,
  });

  factory SuccessPostJobModel.fromJson(Map<String, dynamic> json) => SuccessPostJobModel(
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
    image: json["image"],
    shareCount: json["share_count"],
    postedByUserid: json["posted_by_userid"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    workplace: json["workplace"] == null ? null : Category.fromJson(json["workplace"]),
    city: json["city"] == null ? null : CitiesModel.fromJson(json["city"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    files: json["files"] == null ? [] : List<FileElement>.from(json["files"]!.map((x) => FileElement.fromJson(x))),
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
    "image": image,
    "share_count": shareCount,
    "posted_by_userid": postedByUserid,
    "updated_by": updatedBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "category": category?.toJson(),
    "workplace": workplace?.toJson(),
    "city": city?.toJson(),
    "user": user?.toJson(),
    "files": files == null ? [] : List<dynamic>.from(files!.map((x) => x.toJson())),
  };
}

