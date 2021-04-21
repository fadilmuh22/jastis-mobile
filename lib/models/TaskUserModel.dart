part of 'models.dart';

class TaskUserModel {
  TaskUserModel({
    this.id,
    this.userId,
    this.taskId,
    this.data,
    this.score,
    this.updatedAt,
    this.createdAt,
    this.title,
    this.desc,
    this.users,
  });

  String id;
  String userId;
  String taskId;
  List<String> data;
  dynamic score;
  DateTime updatedAt;
  DateTime createdAt;
  String title;
  String desc;
  UserModel users;

  factory TaskUserModel.fromJson(Map<String, dynamic> json) => TaskUserModel(
      id: json["_id"],
      userId: json["user_id"],
      taskId: json["task_id"],
      data: json["data"] == null
          ? null
          : List<String>.from(json["data"].map((x) => x)),
      score: json["score"],
      updatedAt: DateTime.parse(json["updated_at"]),
      createdAt: DateTime.parse(json["created_at"]),
      title: json["title"],
      desc: json["desc"],
      users: json['users'] == null ? null : UserModel.fromJson(json['users']));

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "task_id": taskId,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x)),
        "score": score,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "title": title,
        "desc": desc,
        "users": users == null ? null : users.toJson(),
      };
}
