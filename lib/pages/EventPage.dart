part of 'pages.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(Constants.kDefaultPadding),
      children: [
        _eventContainer("Missing"),
        _eventContainer("Done"),
        _eventContainer("Upcoming"),
      ],
    );
  }

  _eventContainer(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          getSeparateDivider(title),
          _eventList(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: Text('More'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _eventList() {
    return Consumer(builder: (context, watch, child) {
      final tasks = watch(taskProvider);
      return Column(
        children: [
          taskEventItem(tasks.tasks[0]),
        ],
      );
    });
  }
}
