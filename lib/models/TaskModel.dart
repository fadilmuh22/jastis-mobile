part of 'models.dart';

class TaskModel {
  TaskModel({
    this.id,
    this.userId,
    this.kelasId,
    this.title,
    this.desc,
    this.dateStart,
    this.dateEnd,
    this.createdAt,
    this.updatedAt,
    this.kelas,
    this.users,
  });

  String id;
  String userId;
  String kelasId;
  String title;
  String desc;
  DateTime dateStart;
  DateTime dateEnd;
  DateTime createdAt;
  DateTime updatedAt;
  KelasModel kelas;
  UserModel users;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["_id"],
        userId: json["user_id"],
        kelasId: json["kelas_id"],
        title: json["title"],
        desc: json["desc"],
        dateStart: DateTime.parse(json["date_start"]),
        dateEnd: DateTime.parse(json["date_end"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        kelas: KelasModel.fromJson(json["kelas"]),
        users: UserModel.fromJson(json["users"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "kelas_id": kelasId,
        "title": title,
        "desc": desc,
        "date_start": dateStart.toIso8601String(),
        "date_end": dateEnd.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "kelas": kelas.toJson(),
        "users": users.toJson(),
      };
}
