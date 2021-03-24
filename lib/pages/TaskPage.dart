part of 'pages.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(Constants.kDefaultPadding),
      children: [
        _taskContainer("Missing"),
        _taskContainer("Done"),
        _taskContainer("Upcoming"),
      ],
    );
  }

  _taskContainer(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          getSeparateDivider(title),
          _taskList(),
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

  Widget _taskList() {
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
