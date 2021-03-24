part of 'models.dart';

class EventModel extends BaseTaskEventModel {
  EventModel({
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
}
