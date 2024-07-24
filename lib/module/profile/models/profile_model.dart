import 'package:postprob/module/profile/models/list_data_model.dart';

class ProfileModel {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? gender;
  String? dob;
  dynamic cityId;
  String? state;
  String? city;
  List<ListDataModel>? skills;
  String? aboutMe;
  String? image;
  String? isVendor;
  int? isNotification;
  String? cityState;
  Experience? experience;
  Education? education;
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
    this.isVendor,
    this.isNotification,
    this.cityState,
    this.experience,
    this.education,
    this.documents,
    this.languages,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        mobile: json["mobile"] ?? "",
        gender: json["gender"] ?? "",
        dob: json["dob"] ?? "",
        cityId: json["city_id"] ?? "",
        state: json["state"] ?? "",
        city: json["city"] ?? "",
        skills: json["skills"] == null ? [] : List<ListDataModel>.from(json["skills"]!.map((x) => ListDataModel.fromJson(x))),
        aboutMe: json["about_me"] ?? "",
        image: json["image"] ?? "",
        isVendor: json["is_vendor"] ?? "",
        isNotification: json["is_notification"] ?? 0,
        cityState: json["citystate"] ?? "",
        experience: json["experience"] == null ? null : Experience.fromJson(json["experience"]),
        education: json["education"] == null ? null : Education.fromJson(json["education"]),
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
        "is_vendor": isVendor,
        "is_notification": isNotification,
        "citystate": cityState,
        "experience": experience?.toJson(),
        "education": education?.toJson(),
        "documents": documents == null ? [] : List<dynamic>.from(documents!.map((x) => x.toJson())),
        "languages": languages == null ? [] : List<dynamic>.from(languages!.map((x) => x.toJson())),
      };
}

class Document {
  int? id;
  int? userId;
  String? title;
  String? document;

  Document({
    this.id,
    this.userId,
    this.title,
    this.document,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        id: json["id"] ?? 0,
        userId: json["user_id"] ?? 0,
        title: json["title"] ?? "",
        document: json["document"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "document": document,
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
  });

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        id: json["id"] ?? 0,
        userId: json["user_id"] ?? 0,
        educationLavelId: json["education_lavel_id"] ?? 0,
        educationLavel: json["education_lavel"] ?? "",
        institutionName: json["institution_name"] ?? "",
        fieldOfStudy: json["field_of_study"] ?? "",
        startDate: json["start_date"] ?? "",
        endDate: json["end_date"] ?? "",
        description: json["description"] ?? "",
        isPosition: json["is_position"] ?? 0,
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

  Experience({
    this.id,
    this.userId,
    this.title,
    this.company,
    this.startDate,
    this.endDate,
    this.description,
    this.isPosition,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        id: json["id"] ?? 0,
        userId: json["user_id"] ?? 0,
        title: json["title"] ?? "",
        company: json["company"] ?? "",
        startDate: json["start_date"] ?? "",
        endDate: json["end_date"] ?? "",
        description: json["description"] ?? "",
        isPosition: json["is_position"] ?? 0,
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
