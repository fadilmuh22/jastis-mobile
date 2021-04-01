part of 'models.dart';

class UserModel {
  UserModel({
    this.id,
    this.name,
    this.email,
    this.updatedAt,
    this.createdAt,
    this.userKelas,
    this.kelas,
  });

  String id;
  String name;
  String email;
  DateTime updatedAt;
  DateTime createdAt;
  List<dynamic> userKelas;
  List<dynamic> kelas;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        // userKelas: List<dynamic>.from(json["user_kelas"].map((x) => x)),
        // kelas: List<dynamic>.from(json["kelas"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        // "user_kelas": List<dynamic>.from(userKelas.map((x) => x)),
        // "kelas": List<dynamic>.from(kelas.map((x) => x)),
      };
}
