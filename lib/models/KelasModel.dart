part of 'models.dart';

class KelasModel {
  KelasModel({
    this.id,
    this.userId,
    this.name,
    this.code,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String userId;
  String name;
  String code;
  DateTime createdAt;
  DateTime updatedAt;

  factory KelasModel.fromJson(Map<String, dynamic> json) => KelasModel(
        id: json["_id"],
        userId: json["user_id"],
        name: json["name"],
        code: json["code"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "name": name,
        "code": code,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
