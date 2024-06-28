class UserModel {
  bool? status;
  String? accessToken;
  String? tokenType;
  String? message;
  Data? dataUser;

  UserModel({this.status, this.accessToken, this.tokenType, this.message});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    message = json['message'];
    dataUser = json['data'] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    data['message'] = message;
    data['data'] = dataUser?.toJson();
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? isVendor;

  Data({
    this.id,
    this.name,
    this.email,
    this.isVendor,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        isVendor: json["is_vendor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "is_vendor": isVendor,
      };
}
