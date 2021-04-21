part of 'models.dart';

class UserModel {
  UserModel({
    this.id,
    this.avatar,
    this.googleId,
    this.registrationId,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.userKelas,
    this.kelas,
  });

  String id;
  String avatar;
  String googleId;
  String registrationId;
  String name;
  String email;
  DateTime emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  List<KelasModel> userKelas;
  List<KelasModel> kelas;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["_id"],
      avatar: json["avatar"],
      googleId: json["googleId"],
      registrationId: json["registrationId"],
      name: json["name"],
      email: json["email"],
      emailVerifiedAt: json["email_verified_at"] == null
          ? null
          : DateTime.parse(json["email_verified_at"]),
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      userKelas: json["user_kelas"] == null
          ? null
          : List<KelasModel>.from(
              json["user_kelas"].map((x) => KelasModel.fromJson(x))),
      kelas: json["kelas"] == null
          ? null
          : List<KelasModel>.from(
              json["kelas"].map((x) => KelasModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "avatar": avatar,
      "google_id": googleId,
      "registration_id": registrationId,
      "name": name,
      "email": email,
      "email_verified_at":
          emailVerifiedAt == null ? null : emailVerifiedAt.toIso8601String(),
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
      "user_kelas": userKelas == null
          ? null
          : List<dynamic>.from(userKelas.map((x) => x.toJson())),
      "kelas": kelas == null
          ? null
          : List<dynamic>.from(kelas.map((x) => x.toJson())),
    };
  }
}
