part of '../pages.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final KelasController _kelasc = KelasController.to;

  final ScreenController _screenc = ScreenController.to;

  DateFormat dateFormat = DateFormat("MMM yyyy");
  String currentDateString;

  DateTime now = DateTime.now();
  List<int> thisWeekday = [];

  @override
  void initState() {
    super.initState();

    int currentDay = now.weekday;
    DateTime sunday = now.subtract(Duration(days: currentDay));

    for (int i = 0; i <= 6; i++) {
      thisWeekday.add(sunday.add(Duration(days: i)).day);
    }
    currentDateString = dateFormat.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'home-page',
        tooltip: 'Refresh home page',
        child: Icon(Icons.refresh),
        onPressed: () async {
          _kelasc.getTask(context);
        },
      ),
      body: _homeListView(),
    );
  }

  ListView _homeListView() {
    var days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    DateFormat dateFormat = DateFormat("E");
    String today = dateFormat.format(now);

    return ListView(
      padding: EdgeInsets.all(Constants.kDefaultPadding + 6),
      children: [
        _daysListView(days, today),
        ..._todayTasks(),
        SizedBox(height: 20),
        ..._upcoming(),
      ],
    );
  }

  SizedBox _daysListView(List<String> days, String today) {
    return SizedBox(
      height: 80,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          ...List.generate(
            days.length,
            (index) {
              return GestureDetector(
                // onTap: _eventDetailMBS,
                child: Container(
                  width: 55,
                  child: Card(
                    color: days[index] == today
                        ? Color(0xFFD1C5F1).withOpacity(.3)
                        : Colors.white,
                    elevation: 0,
                    child: Center(
                      child: Text(
                        '${days[index]}\n${thisWeekday[index]}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: days[index] == today
                              ? Constants.kPrimaryColor
                              : Color(0xFFD8CFF2),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  List _todayTasks() {
    return [
      ListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 6),
        title: Text(
          'Today\'s  Task',
          style: Theme.of(context).textTheme.headline2,
        ),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          _screenc.onTabTapped(1);
        },
      ),
      _todayTasksListView(),
    ];
  }

  Widget _todayTasksListView() {
    return Obx(() {
      if (_kelasc.isLoadingTask.value) {
        return Center(child: CircularProgressIndicator());
      }
      return _kelasc.listTask.value == null || _kelasc.listTask.value.isEmpty
          ? Container(
              height: 36,
              child: Center(
                child: Text(
                  'You don\'t have any tasks yet',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            )
          : SizedBox(
              height: 240,
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(bottom: 10),
                itemCount: _kelasc.listTask.value.length > 5
                    ? 5
                    : _kelasc.listTask.value.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    _taskListViewItem(context, _kelasc.listTask.value[index]),
              ),
            );
    });
  }

  Widget _taskListViewItem(BuildContext context, TaskModel task) {
    return GestureDetector(
      onTap: () {
        Get.to(() => TaskDetailPage(task: task));
      },
      child: SizedBox(
        width: 150,
        height: 240,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: Image.network(
                      'https://placeimg.com/130/169/tech',
                      width: 130,
                      height: 169,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          '${task.title}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF5D5454),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${task.dateStart}',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(223, 87, 83, 0.87),
                    ),
                  ),
                  Text(
                    '${task.dateEnd}',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List _upcoming() {
    return [
      Text(
        'Upcoming\'s  Task',
        style: Theme.of(context).textTheme.headline2,
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        child: Card(
          elevation: 0,
          color: Color(0xFF897AB6).withOpacity(.51),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ];
  }
}
