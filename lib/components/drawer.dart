part of 'components.dart';

ListTile listTileKelas(BuildContext context, KelasModel kelas) {
  return ListTile(
    dense: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 6),
    leading: CircleAvatar(
      backgroundColor: Color(int.parse('0xFF${kelas.color}')),
    ),
    title: Text(
      '${kelas.name}',
      style: Theme.of(context).textTheme.caption.copyWith(fontSize: 11),
    ),
    subtitle: Text(
      '${kelas.users.name}',
      style: Theme.of(context).textTheme.subtitle2,
    ),
    onTap: () {
      Get.to(() => ClassDetailPage(kelas: kelas));
    },
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
  final KelasController _kelasc = KelasController.to;
  UserModel _user;

  List<KelasModel> _teaching;

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
                                  leading: CircleAvatar(
                                    backgroundImage: _user.avatar == null
                                        ? null
                                        : NetworkImage('${_user.avatar}'),
                                  ),
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
                            _teachingClasses(context),
                            SizedBox(height: 30),
                            _joinedClasses(context),
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

  Widget _teachingClasses(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Teaching',
        ),
        Padding(
          padding: EdgeInsets.only(left: 4),
          child: Column(
            children: [
              Obx(() {
                if (_kelasc.isLoadingKelas.value) {
                  return CircularProgressIndicator();
                }
                return _kelasc.teachingKelas.value == null ||
                        _kelasc.teachingKelas.value.isEmpty
                    ? Container(
                        height: 36,
                        child: Center(
                          child: Text(
                            'You haven\'t teach any class yet',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _kelasc.teachingKelas.value.length > 3
                                ? 3
                                : _kelasc.teachingKelas.value.length,
                            itemBuilder: (context, index) {
                              return listTileKelas(
                                  context, _kelasc.teachingKelas.value[index]);
                            },
                          ),
                          if (_kelasc.teachingKelas.value.length > 3)
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
                                      color: Constants.kPrimaryColor,
                                      fontSize: 12,
                                    ),
                              ),
                            ),
                        ],
                      );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _joinedClasses(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Joined Classes',
        ),
        Padding(
          padding: EdgeInsets.only(left: 4),
          child: Column(
            children: [
              Obx(() {
                if (_kelasc.isLoadingKelas.value) {
                  return CircularProgressIndicator();
                }
                return _kelasc.joinedKelas.value == null ||
                        _kelasc.joinedKelas.value.isEmpty
                    ? Container(
                        height: 36,
                        child: Center(
                          child: Text(
                            'You haven\'t join any class yet',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _kelasc.joinedKelas.value.length > 3
                                ? 3
                                : _kelasc.joinedKelas.value.length,
                            itemBuilder: (context, index) {
                              return listTileKelas(
                                  context, _kelasc.joinedKelas.value[index]);
                            },
                          ),
                          if (_kelasc.joinedKelas.value.length > 3)
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
                                      color: Constants.kPrimaryColor,
                                      fontSize: 12,
                                    ),
                              ),
                            ),
                        ],
                      );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
