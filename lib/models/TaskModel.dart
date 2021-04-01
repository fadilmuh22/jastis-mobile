part of 'models.dart';

class TaskModel extends BaseTaskEventModel {
  TaskModel({
    String title,
    String desc,
    String startDate,
    String endDate,
    String fromClass,
  }) : super(
          title: title,
          desc: desc,
          startDate: startDate,
          endDate: endDate,
          fromClass: fromClass,
        );

  factory TaskModel.fromJson(json) {
    return TaskModel(
      title: json['title'],
      desc: json['body'],
      startDate: json['title'],
      endDate: json['title'],
      fromClass: json['title'],
    );
  }
}
