part of 'components.dart';

class TaskOrEvent {
  static final TASK = Colors.blue;
  static final EVENT = Colors.yellow;
}

class Drawhorizontalline extends CustomPainter {
  Paint _paint;
  bool reverse;

  Drawhorizontalline(this.reverse) {
    _paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (reverse) {
      canvas.drawLine(Offset(-250.0, 0.0), Offset(-10.0, 0.0), _paint);
    } else {
      canvas.drawLine(Offset(10.0, 0.0), Offset(250.0, 0.0), _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

Widget noItems(String itemName) {
  return Container(
    child: Center(
      child: Text(
        'There is no current $itemName' + 's',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

class CustomDrawer extends StatefulWidget {
  CustomDrawer({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final AuthController _auth = AuthController.to;
  UserModel _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.user.value;
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(9),
          bottomRight: Radius.circular(9),
        ),
        child: Container(
          width: 300,
          padding: EdgeInsets.zero,
          child: Stack(
            children: [
              Drawer(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: bottom),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  leading: CircleAvatar(),
                                  title: Text('${_user.name}'),
                                  subtitle: Text('${_user.email}'),
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.all(20),
                          children: [
                            Text(
                              'Your Classes',
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 4),
                              child: Column(
                                children: [
                                  _user.kelas == null || _user.kelas.isEmpty
                                      ? Container(
                                          height: 36,
                                          child: Center(
                                            child: Text(
                                              'You haven\'t join any class yet',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                            ),
                                          ),
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: _user.kelas.length,
                                          itemBuilder: (context, index) {
                                            return _listTileKelas(context);
                                          },
                                        ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30),
                            ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              leading: Icon(Icons.notifications),
                              title: Text('Notifications'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NotificationsPage(),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              leading: Icon(Icons.settings),
                              title: Text('Settings'),
                              onTap: () {},
                            ),
                            SizedBox(height: 30),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Logout',
                              ),
                              style: ButtonStyle(
                                alignment: Alignment.centerLeft,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile _listTileKelas(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 6),
      leading: CircleAvatar(),
      title: Text(
        'Basis Data',
        style: Theme.of(context).textTheme.caption.copyWith(fontSize: 11),
      ),
      subtitle: Text(
        'Today',
        style: Theme.of(context).textTheme.subtitle2,
      ),
      onTap: () {},
    );
  }
}
