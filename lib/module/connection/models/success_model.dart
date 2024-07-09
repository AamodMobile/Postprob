

import 'package:postprob/module/connection/models/post_list_model.dart';

class SuccessModel {
  int? userId;
  String? jobId;
  dynamic info;
  String? resume;
  String? updatedAt;
  String? createdAt;
  int? id;
  PostListModel? jobDetail;

  SuccessModel({
    this.userId,
    this.jobId,
    this.info,
    this.resume,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.jobDetail,
  });

  factory SuccessModel.fromJson(Map<String, dynamic> json) => SuccessModel(
    userId: json["user_id"],
    jobId: json["job_id"],
    info: json["info"],
    resume: json["resume"],
    updatedAt: json["updated_at"] ,
    createdAt: json["created_at"] ,
    id: json["id"],
    jobDetail: json["job_detail"] == null ? null : PostListModel.fromJson(json["job_detail"]),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "job_id": jobId,
    "info": info,
    "resume": resume,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "id": id,
    "job_detail": jobDetail?.toJson(),
  };
}

