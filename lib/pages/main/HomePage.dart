part of '../pages.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return _homeListView();
  }

  ListView _homeListView() {
    var days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    DateFormat dateFormat = DateFormat("E");
    String today = dateFormat.format(now);

    return ListView(
      padding: EdgeInsets.all(Constants.kDefaultPadding + 6),
      children: [
        SizedBox(
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
        ),
        ..._todayTasks(),
        SizedBox(height: 20),
        ..._upcoming(),
      ],
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
        onTap: () {},
      ),
      _todayTasksListView(),
    ];
  }

  Widget _todayTasksListView() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskDetailPage(),
          ),
        );
      },
      child: SizedBox(
        height: 240,
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.only(bottom: 10),
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Column(
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
                    Text(
                      'Basis Data',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF5D5454),
                      ),
                    ),
                    Text(
                      'Today',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(223, 87, 83, 0.87),
                      ),
                    ),
                    Text(
                      'end in 3 hours',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              ),
            ],
          ),
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
