part of 'components.dart';

ListTile listTileKelas(BuildContext context, KelasModel kelas) {
  return ListTile(
    dense: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 6),
    leading: CircleAvatar(),
    title: Text(
      '${kelas.name}',
      style: Theme.of(context).textTheme.caption.copyWith(fontSize: 11),
    ),
    subtitle: Text(
      '${kelas.createdAt}',
      style: Theme.of(context).textTheme.subtitle2,
    ),
    onTap: () {},
  );
}

class CustomDrawer extends StatefulWidget {
  CustomDrawer({
    Key key,
    @required this.context,
    @required this.moreClassOnTap,
  }) : super(key: key);

  final BuildContext context;
  final Function moreClassOnTap;

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
                                  _user.kelas == null
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
                                      : Column(
                                          children: [
                                            ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: 3,
                                              itemBuilder: (context, index) {
                                                return listTileKelas(
                                                    context, _user.kelas[0]);
                                              },
                                            ),
                                            if (_user.kelas.length > 3)
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  this.widget.moreClassOnTap();
                                                },
                                                child: Text(
                                                  'More',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption
                                                      .copyWith(
                                                        color: Constants
                                                            .kPrimaryColor,
                                                        fontSize: 12,
                                                      ),
                                                ),
                                              ),
                                          ],
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
                              onPressed: () async {
                                await _auth.logout(context);
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()),
                                    (route) => false);
                              },
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
}
