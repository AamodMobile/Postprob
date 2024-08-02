class UserModel {
  bool? status;
  String? accessToken;
  String? tokenType;
  String? message;
  User? dataUser;

  UserModel({this.status, this.accessToken, this.tokenType, this.message});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    message = json['message'];
    dataUser = json['data'] != null ? User.fromJson(json["data"]) : null;
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

class User {
  int? id;
  String? name;
  String? email;
  String? isVendor;
  String? mobile;
  String? gender;
  String? dob;
  String? image;
  dynamic state;
  dynamic city;

  User({
    this.id,
    this.name,
    this.email,
    this.isVendor,
    this.mobile,
    this.gender,
    this.dob,
    this.image,
    this.city,
    this.state,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        isVendor: json["is_vendor"] ?? "",
        mobile: json["mobile"] ?? "",
        gender: json["gender"] ?? "",
        dob: json["dob"] ?? "",
        image: json["image"] ?? "",
        state: json["state"] ?? "",
        city: json["city"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "is_vendor": isVendor,
        "mobile": mobile,
        "gender": gender,
        "dob": dob,
        "image": image,
    "state": state,
    "city": city,
      };
}
