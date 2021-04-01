part of 'data.dart';

class TaskNotifier extends ChangeNotifier {
  List<BaseTaskEventModel> _tasks = [
    TaskModel(
      title: "Title",
      desc: "Desc",
      endDate: "Tomorrow",
      startDate: "Today",
      fromClass: "This Class",
    ),
    TaskModel(
      title: "Title",
      desc: "Desc",
      endDate: "Tomorrow",
      startDate: "Today",
      fromClass: "This Class",
    ),
    EventModel(
      title: "Title",
      desc: "Desc",
      endDate: "Tomorrow",
      startDate: "Today",
      fromClass: "This Class",
    ),
    EventModel(
      title: "Title",
      desc: "Desc",
      endDate: "Tomorrow",
      startDate: "Today",
      fromClass: "This Class",
    ),
  ];

  List<BaseTaskEventModel> get tasks => _tasks;
}
