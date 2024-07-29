

import 'package:postprob/module/profile/models/list_data_model.dart';

class ProfileModel {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? gender;
  String? dob;
  int? cityId;
  dynamic state;
  dynamic city;
  List<ListDataModel>? skills;
  String? aboutMe;
  String? image;
  dynamic emailVerifiedAt;
  String? deviceKey;
  String? isApproved;
  int? isNotification;
  int? isPremium;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? deletedAt;
  String? citystate;
  int? totalPosts;
  List<Experience>? experience;
  List<Education>? education;
  List<Document>? documents;
  List<LanguageElement>? languages;

  ProfileModel({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.gender,
    this.dob,
    this.cityId,
    this.state,
    this.city,
    this.skills,
    this.aboutMe,
    this.image,
    this.emailVerifiedAt,
    this.deviceKey,
    this.isApproved,
    this.isNotification,
    this.isPremium,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.citystate,
    this.totalPosts,
    this.experience,
    this.education,
    this.documents,
    this.languages,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    mobile: json["mobile"],
    gender: json["gender"],
    dob: json["dob"],
    cityId: json["city_id"],
    state: json["state"],
    city: json["city"],
    skills: json["skills"] == null ? [] : List<ListDataModel>.from(json["skills"]!.map((x) => ListDataModel.fromJson(x))),
    aboutMe: json["about_me"],
    image: json["image"],
    emailVerifiedAt: json["email_verified_at"],
    deviceKey: json["device_key"],
    isApproved: json["is_approved"],
    isNotification: json["is_notification"],
    isPremium: json["is_premium"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    citystate: json["citystate"],
    totalPosts: json["total_posts"],
    experience: json["experience"] == null ? [] : List<Experience>.from(json["experience"]!.map((x) => Experience.fromJson(x))),
    education: json["education"] == null ? [] : List<Education>.from(json["education"]!.map((x) => Education.fromJson(x))),
    documents: json["documents"] == null ? [] : List<Document>.from(json["documents"]!.map((x) => Document.fromJson(x))),
    languages: json["languages"] == null ? [] : List<LanguageElement>.from(json["languages"]!.map((x) => LanguageElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "mobile": mobile,
    "gender": gender,
    "dob": dob,
    "city_id": cityId,
    "state": state,
    "city": city,
    "skills": skills == null ? [] : List<dynamic>.from(skills!.map((x) => x.toJson())),
    "about_me": aboutMe,
    "image": image,
    "email_verified_at": emailVerifiedAt,
    "device_key": deviceKey,
    "is_approved": isApproved,
    "is_notification": isNotification,
    "is_premium": isPremium,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "citystate": citystate,
    "total_posts": totalPosts,
    "experience": experience == null ? [] : List<dynamic>.from(experience!.map((x) => x.toJson())),
    "education": education == null ? [] : List<dynamic>.from(education!.map((x) => x.toJson())),
    "documents": documents == null ? [] : List<dynamic>.from(documents!.map((x) => x.toJson())),
    "languages": languages == null ? [] : List<dynamic>.from(languages!.map((x) => x.toJson())),
  };
}

class Document {
  int? id;
  int? userId;
  String? title;
  String? document;
  DateTime? createdAt;
  DateTime? updatedAt;

  Document({
    this.id,
    this.userId,
    this.title,
    this.document,
    this.createdAt,
    this.updatedAt,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
    id: json["id"],
    userId: json["user_id"],
    title: json["title"],
    document: json["document"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "title": title,
    "document": document,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Education {
  int? id;
  int? userId;
  int? educationLavelId;
  String? educationLavel;
  String? institutionName;
  String? fieldOfStudy;
  String? startDate;
  String? endDate;
  String? description;
  dynamic isPosition;
  DateTime? createdAt;
  DateTime? updatedAt;

  Education({
    this.id,
    this.userId,
    this.educationLavelId,
    this.educationLavel,
    this.institutionName,
    this.fieldOfStudy,
    this.startDate,
    this.endDate,
    this.description,
    this.isPosition,
    this.createdAt,
    this.updatedAt,
  });

  factory Education.fromJson(Map<String, dynamic> json) => Education(
    id: json["id"],
    userId: json["user_id"],
    educationLavelId: json["education_lavel_id"],
    educationLavel: json["education_lavel"],
    institutionName: json["institution_name"],
    fieldOfStudy: json["field_of_study"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    description: json["description"],
    isPosition: json["is_position"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "education_lavel_id": educationLavelId,
    "education_lavel": educationLavel,
    "institution_name": institutionName,
    "field_of_study": fieldOfStudy,
    "start_date": startDate,
    "end_date": endDate,
    "description": description,
    "is_position": isPosition,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Experience {
  int? id;
  int? userId;
  String? title;
  String? company;
  String? startDate;
  String? endDate;
  String? description;
  dynamic isPosition;
  DateTime? createdAt;
  DateTime? updatedAt;

  Experience({
    this.id,
    this.userId,
    this.title,
    this.company,
    this.startDate,
    this.endDate,
    this.description,
    this.isPosition,
    this.createdAt,
    this.updatedAt,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
    id: json["id"],
    userId: json["user_id"],
    title: json["title"],
    company: json["company"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    description: json["description"],
    isPosition: json["is_position"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "title": title,
    "company": company,
    "start_date": startDate,
    "end_date": endDate,
    "description": description,
    "is_position": isPosition,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Skill {
  int? id;
  String? title;
  String? slug;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? deletedAt;

  Skill({
    this.id,
    this.title,
    this.slug,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    image: json["image"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "image": image,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
  };
}


class LanguageElement {
  int? id;
  int? userId;
  int? languageId;
  ListDataModel? language;
  dynamic oralLavel;
  dynamic writtenLavel;
  int? isPrimary;

  LanguageElement({
    this.id,
    this.userId,
    this.languageId,
    this.language,
    this.oralLavel,
    this.writtenLavel,
    this.isPrimary,
  });

  factory LanguageElement.fromJson(Map<String, dynamic> json) => LanguageElement(
        id: json["id"] ?? 0,
        userId: json["user_id"] ?? 0,
        languageId: json["language_id"] ?? 0,
        language: json["language"] == null ? null : ListDataModel.fromJson(json["language"]),
        oralLavel: json["oral_lavel"] ?? "",
        writtenLavel: json["written_lavel"] ?? "",
        isPrimary: json["is_primary"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "language_id": languageId,
        "language": language?.toJson(),
        "oral_lavel": oralLavel,
        "written_lavel": writtenLavel,
        "is_primary": isPrimary,
      };
}
