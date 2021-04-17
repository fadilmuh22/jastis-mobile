part of 'models.dart';

class KelasModel {
  KelasModel({
    this.id,
    this.userId,
    this.role,
    this.owner,
    this.name,
    this.subject,
    this.desc,
    this.code,
    this.color,
    this.createdAt,
    this.updatedAt,
    this.userKelas,
    this.users,
  });

  String id;
  String userId;
  String role;
  String owner;
  String name;
  String subject;
  String desc;
  String code;
  String color;
  DateTime createdAt;
  DateTime updatedAt;
  List<UserModel> userKelas;
  UserModel users;

  factory KelasModel.fromJson(Map<String, dynamic> json) => KelasModel(
        id: json["_id"],
        userId: json["user_id"],
        role: json['role'],
        owner: json['owner'],
        name: json["name"],
        subject: json["subject"],
        desc: json["desc"],
        code: json["code"],
        color: json["color"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userKelas: json['user_kelas'] == null
            ? null
            : List<UserModel>.from(
                json["user_kelas"].map((x) => UserModel.fromJson(x))),
        users: json['users'] == null ? null : UserModel.fromJson(json["users"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        'role': role,
        'owner': owner,
        "name": name,
        "subject": subject,
        "desc": desc,
        "code": code,
        "color": color,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_kelas": userKelas == null
            ? null
            : List<dynamic>.from(userKelas.map((x) => x.toJson())),
        "users": users == null ? null : users.toJson(),
      };
}
